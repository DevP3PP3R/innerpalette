import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:innerpalette/provider/color_provider.dart';

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
                  return AlertDialog(
                    title: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text('가까운 색을 골라보세요'),
                    ),
                    content: SingleChildScrollView(
                      child: MaterialPicker(
                        pickerColor:
                            selectedColor ?? Color(Colors.green[700]!.value),
                        onColorChanged: (c) {
                          colorProvider.setSelectedColor(c);
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        enableLabel: false,
                        portraitOnly: true,
                      ),
                    ),
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedColor ?? pickedColor,
              shadowColor: selectedColor ?? pickedColor,
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
