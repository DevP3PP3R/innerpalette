import 'package:flutter/material.dart';
import 'package:innerpalette/screens/login_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SafeArea(child: LoginPage()),
    );
  }
}
