import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/color_provider.dart';
import '../provider/img_provider.dart';
import '../screens/setting_page.dart';

class BtmNavBar extends StatelessWidget {
  const BtmNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final imgProvider = Provider.of<ImgProvider>(context);

    void clearAllProvider() {
      colorProvider.clearPickedColor();
      colorProvider.clearSelectedColor();
      imgProvider.clearPreviewImage();
    }

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
      onDestinationSelected: (int index) {
        if (index == 1) {
          clearAllProvider();
        }
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsPage()),
          );
        }
      },
    );
  }
}
