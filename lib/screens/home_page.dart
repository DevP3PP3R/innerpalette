import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:innerpalette/screens/sucess_page.dart';
import 'package:innerpalette/widget/bottom_nav_bar.dart';

import 'package:innerpalette/widget/image_select.dart';
import 'package:provider/provider.dart';
import '../provider/color_provider.dart';
import '../widget/main_color.dart';
import 'pick_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final picker = ImagePicker();
  deviceheight(BuildContext context) => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final selectedColor = colorProvider.selectedColor;
    final pickedColor = colorProvider.pickedColor;
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
                  (selectedColor != null)
                      ? (selectedColor.red - pickedColor!.red).abs() < 10 &&
                              (selectedColor.green - pickedColor.green).abs() <
                                  10 &&
                              (selectedColor.blue - pickedColor.blue).abs() < 10
                          ? const SucessPage()
                          : MainColor(
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
