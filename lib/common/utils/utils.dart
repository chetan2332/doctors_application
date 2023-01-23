import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({required BuildContext context, required String error}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error),
    ),
  );
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final XFile? img =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
    }
  } catch (err) {
    showSnackBar(context: context, error: err.toString());
  }
  return image;
}
