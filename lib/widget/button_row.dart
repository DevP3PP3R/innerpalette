import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:innerpalette/provider/color_provider.dart';
import 'package:provider/provider.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    super.key,
    required this.deviceWidth,
    required this.pickedColor,
    required this.selectedColor,
    required this.colorProvider,
  });

  final double deviceWidth;
  final ui.Color? pickedColor;
  final ui.Color? selectedColor;
  final ColorProvider colorProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // 고른 색상 표시
            width: deviceWidth * 0.3,
            height: deviceWidth * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(deviceWidth * 0.15),
              color: pickedColor ?? Colors.green[700],
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          // 색상 고르기 버튼
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  final colorProvider =
                      Provider.of<ColorProvider>(context, listen: false);
                  Color? selectedColor = colorProvider.selectedColor;

                  return AlertDialog(
                    title: const Center(
                      child: Text(
                        '팔레트를 둘러볼까요?',
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: deviceWidth * 0.15,
                                  height: deviceWidth * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.25),
                                    color: pickedColor,
                                  ),
                                ),
                                const Text('가까운 색을\n골라보세요',
                                    style: TextStyle(fontSize: 25)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MaterialPicker(
                            pickerColor: selectedColor ??
                                Color(Colors.green[700]!.value),
                            onColorChanged: (c) {
                              colorProvider.setSelectedColor(c);
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            enableLabel: false,
                            portraitOnly: true,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: pickedColor,
              shadowColor: pickedColor,
              elevation: 10,
            ),
            child: Text(
              '색상을 맞춰보세요',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: (selectedColor?.computeLuminance() ??
                              pickedColor?.computeLuminance() ??
                              Colors.white.computeLuminance()) >
                          0.5
                      ? Colors.black
                      : Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
