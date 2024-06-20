import 'package:flutter/material.dart';
import 'package:video_app/config/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VideosApp',
      theme: AppTheme().getTheme(),
    );
  }
}
