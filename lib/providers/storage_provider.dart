import 'dart:io';

import 'package:chat/nav/navigators.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageService extends ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload a single url [file] from storage
  Future<String?> upLoadFile(String id, String category, File file) async {
    String? url;

    try {
      if (file is File) {
        String _file = file.path.split('/').last;

        Reference reference =
            _storage.ref().child('files/$id/$category').child(_file);

        UploadTask uploadTask = reference.putFile(file);

        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        url = await snapshot.ref.getDownloadURL();
      }
    } catch (e) {
      logger.v(e);
      return null;
    }

    return url;
  }

  ///Upload Multiple [List<File>] urls to firebaseStore

  Future<List<String>> uploadFiles({
    required String id,
    required String category,
    required List<File> files,
  }) async {
    List<String> uploadUrls = [];

    await Future.wait(
        files.map((File e) async {
          if (e is File) {
            String? url = await upLoadFile(id, category, e);
            if (url != null) {
              uploadUrls.add(url);
            }
          }
        }),
        eagerError: true,
        cleanUp: (_) {
          logger.v('eager Cleaned');
        });
    return uploadUrls;
  }

  Future<void> delete(String url) async {
    var urlRef = _storage.refFromURL(url);

    if (url is String) {
      return urlRef.delete();
    } else {
      return null;
    }
  }



   /// Deleta a list of urls [List<String>] from  firebase Storage
  Future deleteList(List<String> urls) {
    return Future.wait(urls.map((String e) {
      return delete(e);
    }));
  }
}
