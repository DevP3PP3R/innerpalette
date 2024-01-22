import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:innerpalette/widget/bottom_nav_bar.dart';

import 'package:innerpalette/widget/image_select.dart';
import 'package:provider/provider.dart';
import '../provider/color_provider.dart';
import '../widget/main_color.dart';
import 'pick_page.dart';
import 'sucess_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final picker = ImagePicker();
  deviceheight(BuildContext context) => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final selectedColor = colorProvider.selectedColor;
    final pickedColor = colorProvider.pickedColor;

    if (selectedColor != null &&
        pickedColor != null &&
        (selectedColor.red - pickedColor.red).abs() <= 15 &&
        (selectedColor.green - pickedColor.green).abs() <= 15 &&
        (selectedColor.blue - pickedColor.blue).abs() <= 15) {
      colorProvider.setSuccess();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Dialog(
              child: SucessPage(),
            );
          },
        );
      });
    }

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BtmNavBar(),
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
                  ImageSelect(),
                  (selectedColor != null)
                      ? MainColor(
                          deviceWidth: MediaQuery.of(context).size.width,
                          color: selectedColor,
                        )
                      : const PickPage(),
                ]),
          ),
        ),
      ),
    );
  }
}
