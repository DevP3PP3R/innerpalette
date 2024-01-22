import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  Color? _selectedColor;
  Color? _pickedColor;
  bool _isSuccess = false;

  Color? get selectedColor => _selectedColor;
  Color? get pickedColor => _pickedColor;
  bool get isSuccess => _isSuccess;

  void setPickedColor(Color color) {
    _pickedColor = color;
    notifyListeners();
  }

  void setSelectedColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }

  void setSuccess() {
    _isSuccess = true;
    notifyListeners();
  }

  void clearSuccess() {
    _isSuccess = false;
    notifyListeners();
  }

  void clearSelectedColor() {
    _selectedColor = null;
    notifyListeners();
  }

  void clearPickedColor() {
    _pickedColor = null;
    notifyListeners();
  }
}
