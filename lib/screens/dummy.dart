import 'dart:io';

import 'package:flutter/material.dart';
import 'package:organizer_app/Utils/image_helper.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

File? _image;
List<File> _images = [];

ImageHelper imageHelper = ImageHelper();

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              // Text(_image!.path.toString()),
              Center(
                child: CircleAvatar(
                  radius: 100,
                  foregroundImage: _image != null ? FileImage(_image!) : null,
                ),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () async {
              final file = await imageHelper.pickImage();
              if (file.isNotEmpty) {
                final croppedFile = await imageHelper.crop(file: file.first!);
                if (croppedFile != null) {
                  setState(() {
                    _image = File(croppedFile.path);
                  });
                }
              }
            },
            icon: const Icon(Icons.camera)),
        Column(
          children: [
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: _images
                  .map((image) => Image.file(
                        image,
                        height: 100,
                        width: 100,
                      ))
                  .toList(),
            ),
            IconButton(
                onPressed: () async {
                  final files = await imageHelper.pickImage(multiple: true);
                  if (files.isNotEmpty) {
                    setState(() {
                      _images = files.map((file) => File(file!.path)).toList();
                    });
                  }
                },
                icon: const Icon(Icons.add))
          ],
        )
      ],
    );
  }
}
