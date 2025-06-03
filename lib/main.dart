import 'package:flutter/material.dart';
import 'pages/login_screen.dart';
import 'pages/home_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => LoginScreen(),
      '/home': (context) => HomeScreen(),
    },
  ));
}
