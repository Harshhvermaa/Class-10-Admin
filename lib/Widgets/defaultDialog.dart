import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ncert_book_admin/Constants/constants.dart';

Future dialogBox(String Title,bool progress,bool success,bool dismissible) {
  return Get.defaultDialog(
    title: "",
      content: Obx(
        () {
          return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SizedBox(height: 5.h,),
              Text("${Title.obs}",style: SET_FONT_STYLE(32.sp, FontWeight.w400, Colors.black),),
              SizedBox(height: 5.h,),
              progress == true ? CircularProgressIndicator(color: Color(0xffD23402)) : Text(""),
              progress == true ? SizedBox(height: 5.h,) : SizedBox(),
              success == true ? Icon(Icons.check,color: Color(0xffD23402),size: 50.w,):SizedBox(),
              success == true ? SizedBox(height: 5.h,) : SizedBox(),
            ],
          ),
        );
        }
          
      ),
      barrierDismissible: dismissible,
      );
}
