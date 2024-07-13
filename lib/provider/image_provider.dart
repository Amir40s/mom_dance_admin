// image_upload_provider.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ImageUploadProvider with ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Uint8List? _image;
  String? _downloadUrl;

  Uint8List? get image => _image;
  String? get downloadUrl => _downloadUrl;

  Future<void> pickImage() async {
    final image = await ImagePickerWeb.getImageAsBytes();
    if (image != null) {
      _image = image;
      notifyListeners();
    }
  }

  Future<void> uploadImage() async {
    if (_image == null) return;

    final reference = _storage
        .ref('/banner/${DateTime.now().toIso8601String()}');
    final uploadTask = reference.putData(
      _image!,
      SettableMetadata(contentType: 'image/jpeg'), // Ensure the content type
    );
    final snapshot = await uploadTask.whenComplete(() {});
    _downloadUrl = await snapshot.ref.getDownloadURL();
    notifyListeners();
  }
}
