import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/post_detail_screen.dart';
import 'screens/create_post_screen.dart';
import 'models/post.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/signup': (context) => const SignupScreen(),
  '/postDetail': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Post;
    return PostDetailScreen(post: args);
  },
  '/createPost': (context) => const CreatePostScreen(),
};