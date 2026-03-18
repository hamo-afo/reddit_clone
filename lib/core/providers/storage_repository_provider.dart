import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_tutorial/core/failure.dart';
import 'package:reddit_tutorial/core/providers/firebase_providers.dart';
import 'package:reddit_tutorial/core/type_defs.dart';

final storageRepositoryProvider = Provider((ref) => StorageRepository(
      firebaseStorage: ref.watch(storageProvider),
    ));

class StorageRepository {
  final FirebaseStorage _firebaseStorage;
  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;
  FutureEither<String> storeFile({
    required String path,
    required String id,
    required File? file,
  }) async {
    try {
      if (file == null) {
        return left(Failure('File is null'));
      }

      if (kDebugMode)
        print(
            '[StorageRepository] Starting upload: path=$path, id=$id, fileSize=${file.lengthSync()} bytes');

      final ref = _firebaseStorage.ref().child(path).child(id);
      UploadTask uploadTask = ref.putFile(file);

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      if (kDebugMode)
        print('[StorageRepository] Upload complete: $downloadUrl');
      return right(downloadUrl);
    } catch (e) {
      if (kDebugMode) print('[StorageRepository] Upload error: $e');
      return left(Failure(e.toString()));
    }
  }
}
