import 'dart:io';

import 'package:flutter/material.dart';
import 'package:organizer_app/Utils/image_helper.dart';

class ImagePickerProvider extends ChangeNotifier {
  List<File> _imageList = [];
  File? _image;

  ImageHelper imageHelper = ImageHelper();

  List<File> get imageList => _imageList;
  File? get image => _image;

  Future<void> pickImage() async {
    final file = await imageHelper.pickImage();
    if (file.isNotEmpty) {
      final croppedFile = await imageHelper.crop(file: file.first!);
      if (croppedFile != null) {
        _image = File(croppedFile.path);
      }
    }
    notifyListeners();
  }

  Future<void> pickMultipleImages() async {
    final files = await imageHelper.pickImage(multiple: true);
    if (files.isNotEmpty) {
      _imageList = files.map((file) => File(file!.path)).toList();
    }
    notifyListeners();
  }
}
