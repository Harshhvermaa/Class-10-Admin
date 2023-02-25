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

class AllChapters extends StatefulWidget {
  String? subject;
  String? whichClass;
  AllChapters({required this.subject, required this.whichClass});

  @override
  State<AllChapters> createState() => _AllChaptersState();
}

class _AllChaptersState extends State<AllChapters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Chapters of ${widget.subject}"),
        backgroundColor: Color(0xffD23402),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("AppData")
            .doc("${widget.whichClass}")
            .collection("Subjects")
            .doc("${widget.subject}")
            .collection("Chapters of ${widget.subject}")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 30.0.h, vertical: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${snapshot.data!.docs[index].data()["ChapterName"]}",
                          style: SET_FONT_STYLE(
                              32.sp, FontWeight.w300, Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            print("object");
                            firestoreFunction().deletepdf(
                                widget.whichClass!,
                                widget.subject!,
                                "${snapshot.data!.docs[index].data()["ChapterName"]}",
                                context);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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
