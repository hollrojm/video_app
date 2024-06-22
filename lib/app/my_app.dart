import 'package:flutter/material.dart';
import 'package:video_app/config/theme/app_theme.dart';
import 'package:video_app/config/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'VideosApp',
      theme: AppTheme().getTheme(),
    );
  }
}
