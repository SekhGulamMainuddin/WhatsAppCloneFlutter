import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_using_flutter/common/firebase_dependecy_provider.dart';

final commonRepositoryProvider = Provider(
  (ref) => CommonRepository(ref.watch(firebaseStorage)),
);

class CommonRepository {
  final Reference _storage;
  CommonRepository(this._storage);

  Future<String?> uploadFile(File file, String path) async {
    try {
      final uploadFile= await _storage.child(path).putFile(file);
      String url= await uploadFile.ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
