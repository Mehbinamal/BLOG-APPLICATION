from django.shortcuts import render
from django.contrib.auth import authenticate
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import UserSerializer, PostSerializer
from rest_framework.permissions import AllowAny, IsAuthenticated
from .models import Post, UserProfile
from django.shortcuts import get_object_or_404

class LoginView(APIView):
    permission_classes = [AllowAny]
    def post(self,request):
        print(f"Login attempt received: {request.data}")
        username = request.data.get('username')
        password = request.data.get('password')
        print(f"Username: {username}")
        print(f"Password provided: {'Yes' if password else 'No'}")
        
        user = authenticate(username = username, password = password)
        print(f"Authentication result: {user}")
        
        if user is not None:
            refresh = RefreshToken.for_user(user)
            print(f"Login successful for user: {user.username}")
            return Response({
                'token': str(refresh.access_token),
                'user_id': user.id
            })
        else:
            print(f"Login failed for username: {username}")
            return Response({
                'error': 'Invalid credentials'
            }, status=status.HTTP_401_UNAUTHORIZED)

class SignupView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        try:
            serializer = UserSerializer(data=request.data)

            if serializer.is_valid():
                user = serializer.save()
                # UserProfile is automatically created by signal
                return Response({'message': 'User created successfully', 'user_id': user.id}, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            print(f"Signup error: {e}")
            return Response({'error': 'An error occurred during signup'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
class UserProfileView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request, pk):
        profile = UserProfile.objects.get(user=pk)
        serializer = UserSerializer(profile)
        return Response(serializer.data)

class PostListView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request):
        posts = Post.objects.all()
        serializer = PostSerializer(posts, many=True)
        return Response(serializer.data)
    
    def post(self, request):
        print(request.user)
        serializer = PostSerializer(data=request.data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class PostDetailView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request, pk):
        post = get_object_or_404(Post, pk=pk)
        serializer = PostSerializer(post)
        return Response(serializer.data)
    