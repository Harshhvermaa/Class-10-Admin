import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ncert_book_admin/Constants/constants.dart';
import 'package:ncert_book_admin/Widgets/custom_Button.dart';
import 'package:ncert_book_admin/Widgets/defaultDialog.dart';
import 'package:ncert_book_admin/screens/allChapters.dart';

class UploadPDF extends StatefulWidget {
  String? whichClass;
  String? id;
  UploadPDF({this.whichClass, this.id});
  @override
  State<UploadPDF> createState() => _UploadPDFState();
}

class _UploadPDFState extends State<UploadPDF> {
  PlatformFile? pickedfile;
  String? initialValue;
  TextEditingController _chapterName = TextEditingController();
  UploadTask? uploadTask;
  String? downloadURL;
  List<PlatformFile>? _multiFiles;

  selectPDF() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return;
    setState(() {
      _multiFiles = result.files;
      pickedfile = result.files.first;
      // _chapterName.text = pickedfile!.name;
    });
  }

  uploadPDF() async {
    try {
      for (var i = 0; i < _multiFiles!.length; i++) {
        dialogBox("Uploading... $i ", true, false, false);
        final path =
            'Appdata/${widget.whichClass}/${widget.id}/${_multiFiles![i].name}';
        print(_multiFiles![i].name);
        final file = await File(_multiFiles![i].path.toString());
        final ref = FirebaseStorage.instance.ref().child(path);
        uploadTask = ref.putFile(file);
        final snapshot = await uploadTask!.whenComplete(() {});
        downloadURL = await snapshot.ref.getDownloadURL();
        print(downloadURL);

        await FirebaseFirestore.instance
            .collection("AppData")
            .doc("${widget.whichClass}")
            .collection("Subjects")
            .doc("${widget.id}")
            .collection("Chapters of ${widget.id}")
            .doc("${_multiFiles![i].name}")
            .set(
          {
            "ChapterName": "${_multiFiles![i].name}",
            "PDF Link": "${downloadURL}"
          },
        ).then(
          (value) {
            print("$i"+"success");
            Navigator.pop(context);
            // dialogBox(" ${i} Successfully Uploaded", false, true, true);
          },
        );
      }
      print("success");
      dialogBox("Successfully Uploaded", false, true, true);
    } catch (e) {
      Navigator.pop(context);
      print("$e" + "fgdfgdfgfdgfg");
      dialogBox("Upload Fail", false, false, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: SCREEN_WIDTH(context) * 0.2,
                child: CustomButtonWidget(
                  text: "Upload PDF",
                  color: Color(0xffD23402),
                  onPressed: () async {
                    selectPDF();
                  },
                ),
              ),
              if (pickedfile != null)
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 237, 228, 198),
                      borderRadius: BorderRadius.circular(12)),
                  width: SCREEN_WIDTH(context) * 0.8,
                  height: SCREEN_HEIGHT(context) * 0.2,
                  child: ListView.builder(
                    
                    physics: PageScrollPhysics(),
                    itemCount: _multiFiles!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xffD23402),
                          ),
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: Text(
                            _multiFiles![index].name.toString(),
                            style: SET_FONT_STYLE(
                              20.sp,
                              FontWeight.w500,
                              Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: SCREEN_WIDTH(context) * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _chapterName,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      label: const Text("Chapter Name"),
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: SCREEN_WIDTH(context) * 0.7,
                child: CustomButtonWidget(
                  text: "Add Chapter",
                  color: Color(0xffD23402),
                  onPressed: () async {
                    uploadPDF();
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: SCREEN_WIDTH(context) * 0.7,
                child: CustomButtonWidget(
                  text: "All chapters of ${widget.id}",
                  color: Color(0xffD23402),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllChapters(
                        subject: widget.id,
                        whichClass: widget.whichClass,
                      ),
                    ));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
