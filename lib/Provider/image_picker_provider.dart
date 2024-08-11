import 'dart:io';

import 'package:flutter/material.dart';
import 'package:organizer_app/Utils/image_helper.dart';

class ImagePickerProvider extends ChangeNotifier {
  final List<File> _mainEventCoverImages = [];
  final List<File> _subEventCoverImages = [];
  File? _mainEventImage;
  File? _profileImage;

  ImageHelper imageHelper = ImageHelper();

  File? get mainEventImage => _mainEventImage;
  File? get profileImage => _profileImage;

  List<File> get mainEventCoverImages => _mainEventCoverImages;
  List<File> get subEventCoverImages  => _subEventCoverImages;

  Future<void> pickProfileImage() async {
    final file = await imageHelper.pickImage();
    if (file.isNotEmpty) {
      final croppedFile = await imageHelper.crop(file: file.first!);
      if (croppedFile != null) {
        _profileImage = File(croppedFile.path);
      }
    }
    notifyListeners();
  }

  Future<void> pickMainEventImage() async {
    final file = await imageHelper.pickImage();
    if(file.isNotEmpty){
          _mainEventImage = File(file.first!.path);
    }
    notifyListeners();
  }

  Future<void> pickCoverImage({bool isMainEventCoverImages =  true}) async {
    final file = await imageHelper.pickImage();
    if (file.isNotEmpty) {
      if (isMainEventCoverImages) {
        _mainEventCoverImages.add(File(file.first!.path));
      } else {
        _subEventCoverImages.add(File(file.first!.path));
      }
    }
    notifyListeners();
  }

  void removeCoverImage(int index , {bool deleteMainEventCoverImage = true} ){
    if(deleteMainEventCoverImage){
      mainEventCoverImages.removeAt(index);
    }else{
      subEventCoverImages.removeAt(index);
    }
    notifyListeners();
  }
}
