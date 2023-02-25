import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ncert_book_admin/Widgets/defaultDialog.dart';

class firestoreFunction{

  deleteSubject( String whichClass,String subjectName )async{
    FirebaseFirestore.instance
            .collection("AppData")
            .doc("${whichClass}")
            .collection("Subjects")
            .doc("$subjectName")
            .delete();
  }

  deletepdf(String whichClass , String subject, String name ,BuildContext context) async {
    dialogBox("Deleting...", true, false, false);
    try {
      
    final location = 'Appdata/${whichClass}/${subject}/${name}';
    final ref = FirebaseStorage.instance.ref().child(location);
    await ref.delete();
    await deleteChapter(whichClass, subject, name );
    Navigator.pop(context);
    } catch (e) {
      
    Navigator.pop(context);
    dialogBox("${e}", false, false, true);
    }
    

  }

  deleteChapter( String whichClass,String subjectName,String chapterName )async{
   FirebaseFirestore.instance
            .collection("AppData")
            .doc("${whichClass}")
            .collection("Subjects")
            .doc("${subjectName}")
            .collection("Chapters of ${subjectName}")
            .doc("${chapterName}")
            .delete();
  }

  // Future<void> _getImage(ImagePicker _picker) async {
  //   imageXFile = await _picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     imageXFile;
  //   });
  // }
}
