import 'package:chat/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'providers/home_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: HomeController.instance,
      builder: (context, child) {
        return MaterialApp(
          title: 'GioLabs',
          theme: ThemeData(
              primarySwatch: Colors.grey,
              secondaryHeaderColor: Colors.deepOrange,
              brightness: Brightness.dark),
          home: const HomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
