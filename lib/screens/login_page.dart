import 'package:flutter/material.dart';
import 'package:innerpalette/screens/email_login.dart';
import 'package:innerpalette/screens/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: const Text('구글로그인'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmailLogin()));
              },
              child: const Text('이메일로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
