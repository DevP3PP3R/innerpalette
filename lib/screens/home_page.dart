import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:innerpalette/screens/my_page.dart';
import 'package:innerpalette/widget/color_picker.dart';
import 'package:innerpalette/widget/image_upload.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final picker = ImagePicker();
  File? previewImage;
  deviceheight(BuildContext context) => MediaQuery.of(context).size.height;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  setImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    setState(() {
      widget.previewImage = File(image.path);
    });
  }

  imageFromCamera() async {
    var image = await widget.picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );
    if (image != null) {
      setState(() {
        widget.previewImage = File(image.path);
      });
    }
  }

  imageFromGallery() async {
    var image = await widget.picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    if (image != null) {
      setState(() {
        widget.previewImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Home Page')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: widget.deviceheight(context) * 0.1,
                  ),
                  Container(
                    child: (widget.previewImage != null)
                        ? Image.file(
                            widget.previewImage!,
                            width: deviceWidth * 0.8,
                            height: deviceWidth * 0.8,
                          )
                        : const Text('이미지를 선택해주세요'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: imageFromCamera,
                        icon: const Icon(Icons.camera_alt_rounded),
                      ),
                      IconButton(
                          onPressed: imageFromGallery,
                          icon: const Icon(Icons.photo_library)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyPage(),
                        ),
                      );
                    },
                    child: const Text('Go to My Page'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ColorPicker(),
                        ),
                      );
                    },
                    child: const Text('Go to Color Picker'),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
