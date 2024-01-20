import 'package:flutter/material.dart';

class BtmNavBar extends StatelessWidget {
  const BtmNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.person_outline_rounded), label: 'MyPage'),
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
