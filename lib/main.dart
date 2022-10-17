import 'package:chat/providers/home_controller.dart';
import 'package:provider/provider.dart';
import '../pages/tela_inicial.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
          home: const Telainicial(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
