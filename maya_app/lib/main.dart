import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maya_app/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor:
            Colors.transparent, // Make the navigation bar transparent
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}
