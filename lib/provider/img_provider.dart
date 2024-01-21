import 'package:flutter/foundation.dart';

class ImgProvider extends ChangeNotifier {
  String? _previewImage;

  String? get previewImage => _previewImage;

  void setpreviewImage(String imagePath) {
    _previewImage = imagePath;
    notifyListeners();
  }

  void clearPreviewImage() {
    _previewImage = null;
    notifyListeners();
  }
}
