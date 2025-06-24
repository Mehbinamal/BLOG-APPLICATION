from django.contrib.auth.models import User
from rest_framework import serializers
from .models import Post

class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ['username', 'password']

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            password=validated_data['password']
        )
        return user
    
class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = ['id', 'title', 'content', 'author', 'created_at']
        extra_kwargs = {'author': {'read_only': True}}
    
    def create(self, validated_data):
        user = self.context['request'].user
        post = Post.objects.create(
            title=validated_data['title'],
            content=validated_data['content'],
            author=user.userprofile
        )
        return post
    