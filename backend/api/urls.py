from django.urls import path, include
from . import views



urlpatterns = [
    path('login/', views.LoginView.as_view(), name='login'),
    path('signup/', views.SignupView.as_view(), name='signup'),
    path('create-post/', views.PostListView.as_view(), name='create-post'),
    path('posts/', views.PostListView.as_view(), name='post-list'),
    path('posts/<int:pk>/', views.PostDetailView.as_view(), name='post-detail'),
    path('profile/<int:pk>/', views.UserProfileView.as_view(), name='profile'),
]