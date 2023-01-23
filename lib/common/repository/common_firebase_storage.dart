import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseRepositoryProvider = Provider(
  (ref) => CommonFirebaseStorageRepository(FirebaseStorage.instance),
);

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  CommonFirebaseStorageRepository(this.firebaseStorage);

  Future<String> saveFileToFirebase(String locat, File file) async {
    final snap = await firebaseStorage.ref().child(locat).putFile(file);
    String url = await snap.ref.getDownloadURL();
    return url;
  }
}
