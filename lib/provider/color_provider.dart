import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  Color? _selectedColor;
  Color? _pickedColor;

  Color? get selectedColor => _selectedColor;
  Color? get pickedColor => _pickedColor;

  void setSelectedColorFromPicked(Color color) {
    _selectedColor = _pickedColor;
    notifyListeners();
  }

  void setPickedColor(Color color) {
    _pickedColor = color;
    notifyListeners();
  }

  void setSelectedColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }
}
