import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  Color? _selectedColor;
  Color _pickedColor = const Color.fromARGB(255, 0, 72, 188);

  Color? get selectedColor => _selectedColor;
  Color get pickedColor => _pickedColor;

  void setSelectedColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }

  void setPickedColor(Color color) {
    _pickedColor = color;
    notifyListeners();
  }
}
