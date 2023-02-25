import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ncert_book_admin/Constants/constants.dart';
import 'package:ncert_book_admin/Functions/functions.dart';
import 'package:ncert_book_admin/Widgets/custom_Button.dart';
import 'package:ncert_book_admin/screens/uploadPdf.dart';

class AllSubject extends StatefulWidget {
  String whichClass;
  AllSubject({required this.whichClass});

  @override
  State<AllSubject> createState() => _AllSubjectState();
}

class _AllSubjectState extends State<AllSubject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Subjects of ${widget.whichClass}"),
        backgroundColor: Color(0xffD23402),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("AppData")
            .doc("${widget.whichClass}")
            .collection("Subjects")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var base64 = snapshot.data!.docs[index].data()["Icon"];
                Uint8List decodedBase64 = base64Decode(base64);
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xffD23402),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffD23402).withOpacity(0.2),
                        offset: Offset(3.0, 3.9), //(x,y)
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: SizedBox(
                              width: 50.w, child: Image.memory(decodedBase64)),
                          title: Row(
                            children: [
                              SizedBox(
                                  width: 120.w,
                                  child: Text(
                                    "${snapshot.data!.docs[index].id}",
                                    style: SET_FONT_STYLE(
                                        20.sp, FontWeight.w400, Colors.white),
                                  )),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                "${snapshot.data!.docs[index].data()["Class"]}",
                                style: SET_FONT_STYLE(
                                    20, FontWeight.w400, Colors.white),
                              ),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () {
                              firestoreFunction().deleteSubject(
                                  widget.whichClass,
                                  "${snapshot.data!.docs[index].id}");
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8, right: 20),
                        child: SizedBox(
                          width: 130.w,
                          child: CustomButtonWidget(
                            text: "Upload PDF",
                            color: Colors.white,
                            fontSize: 25.sp,
                            textColor: Color(0xffD23402),
                            onPressed: () {
                              Get.to(
                                () => UploadPDF(
                                  whichClass: widget.whichClass,
                                  id: "${snapshot.data!.docs[index].id}",
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
