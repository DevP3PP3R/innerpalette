import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../pickers/hsv_picker.dart';
import '../provider/color_provider.dart';
import '../provider/img_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imgProvider = Provider.of<ImgProvider>(context);
    File? previewImage = (imgProvider.previewImage != null)
        ? File(imgProvider.previewImage!)
        : null;

    final colorProvider = Provider.of<ColorProvider>(context);
    Color? selectedColor = colorProvider.selectedColor;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                previewImage == null
                    ? Container()
                    : Center(
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(previewImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
              ]),
        ),
      ),
    );
  }
}
