import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:innerpalette/screens/my_page.dart';
import 'package:innerpalette/widget/image_upload.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Home Page')),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageUpload(
                                setImage: setImage,
                              ))),
                  child: const Text('이미지업로드')),
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
            ],
          ),
        ),
      ),
    );
  }
}
