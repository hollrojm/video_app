import 'package:flutter/material.dart';
import 'package:video_app/app/my_app.dart';
import 'package:video_app/injection_container.dart' as injection_container;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection_container.init();
  runApp(const MyApp());
}
