import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:innerpalette/widget/bottom_nav_bar.dart';
import 'package:innerpalette/widget/color_picker.dart';
import 'package:innerpalette/widget/image_select.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final picker = ImagePicker();
  File? previewImage;
  deviceheight(BuildContext context) => MediaQuery.of(context).size.height;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  setImage(File image) {
    setState(() {
      widget.previewImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    height: widget.deviceheight(context) * 0.05,
                  ),
                  ImageSelect(setImage: setImage),
                  widget.previewImage == null
                      ? Container()
                      : Center(
                          child: ColorPicker(
                              previewImage: FileImage(widget.previewImage!)),
                        ),
                ]),
          ),
        ),
      ),
    );
  }
}
