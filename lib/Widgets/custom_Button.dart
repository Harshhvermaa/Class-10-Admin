import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Constants/app_colors.dart';
import '../Constants/constants.dart';

class CustomButtonWidget extends StatelessWidget {
  String text;
  VoidCallback? onPressed;
  Color? color;
  Color? textColor;
  var fontSize;
  CustomButtonWidget({required this.text, this.onPressed, this.color,this.textColor,this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
        backgroundColor: MaterialStateProperty.all(color == null ? Colors.white : color),
      ),
      child: Container(
        height: 85.h,
        alignment: Alignment.center,
        width: SCREEN_WIDTH(context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.r),
            // color: color == null ? Colors.white : color
            ),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Text(
          text,
          style: SET_FONT_STYLE(fontSize == null ? 30.sp : fontSize!, FontWeight.w400, textColor == null ? AppColors.whiteColor : textColor! ),
        ),
      ),
    );
  }
}
