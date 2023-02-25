import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';

class databaseService {


  uploadimage(
      String path, String className, String subject, String iconName) async {
    UploadTask uploadTask;
    Reference ref =
        FirebaseStorage.instance.ref("$className/$subject/$iconName");
    FirebaseStorage storage = await FirebaseStorage.instance;
    io.File file = io.File(path);
    await storage.ref("$className/$subject/$iconName").putFile(file);
  }

  fetchImage(String className, String subject, String iconName) async {
    String url = "";
    await FirebaseStorage.instance
        .ref("$className/$subject/$iconName")
        .getDownloadURL()
        .then((value) async {
      url = await value.toString();
    });
    print("sdffds" + url);
    return url;
  }

}
