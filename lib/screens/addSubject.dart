import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';
import 'package:ncert_book_admin/Constants/app_colors.dart';
import 'package:ncert_book_admin/Constants/constants.dart';
import 'package:ncert_book_admin/Database/Databse.dart';
import 'package:ncert_book_admin/Widgets/custom_Button.dart';
import 'package:ncert_book_admin/Widgets/defaultDialog.dart';
import 'package:ncert_book_admin/screens/allSubject.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AddSubject extends StatefulWidget {
  AddSubject({super.key});

  @override
  State<AddSubject> createState() => AddSubjectState();
}

class AddSubjectState extends State<AddSubject> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? imageXFile;
  FormBuilderImagePicker _formBuilderImagePicker =
      FormBuilderImagePicker(name: "");
  bool isImage = false;
  TextEditingController _subject = TextEditingController();
  TextEditingController _aboutSubject = TextEditingController();
  TextEditingController _class = TextEditingController();
  int tag = 0;
  File? _file;
  String? imgBase64 = "";
  XFile? selectedImage;
  String imagePath = '';
  var img = '';
  Uint8List? webImage = Uint8List(10);
  String getImage = '';

  final List<String> _extensionList = [];

  storeDatainList() async {

    var data = await FirebaseFirestore.instance.collection("AppData").get();
    for (var i = 0; i < data.docs.length; i++) {
      print(data.docs[i].id.toString());
      _extensionList.add( data.docs[i].id.toString() );
    }

  }

  void initState()  {
    storeDatainList();
    print(_extensionList);
  }

  createSubject(String subjectName, String Class) async {
    var f = await imageXFile!.readAsBytes();
    String base64 = base64Encode(f);

    try {
      await FirebaseFirestore.instance
          .collection("AppData")
          .doc("$Class")
          .set({"class": "$Class"}).then((value) async {
        await FirebaseFirestore.instance
            .collection("AppData")
            .doc("$Class")
            .collection("Subjects")
            .doc("$subjectName")
            .set({
          "Subject": subjectName,
          "Class": _class,
          "about": _aboutSubject.text,
          "Icon": "$base64",
        });
        Navigator.pop(context);
        await dialogBox("Successfully Created", false, true, true);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AddSubject(),
            ),
            (route) => false);
      });
    } catch (e) {
      Navigator.pop(context);
      dialogBox("$e", false, false, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin Panel"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: GestureDetector(
                onTap: (){
                  Fluttertoast.showToast(msg: "Refresh Complete" );
                  setState(() {
                    
                  });
                },
                child: Icon(Icons.refresh)),
            )
          ],
          backgroundColor: Color(0xffD23402),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 130.h,
              ),
              FormBuilderImagePicker(
                name: 'singleAvatarPhoto',
                transformImageWidget: (context, displayImage) => Card(
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox.expand(
                    child: displayImage,
                  ),
                ),
                showDecoration: false,
                maxImages: 1,
                previewAutoSizeWidth: false,
                onChanged: (value) async {
                  if (value == null) {
                    print("erroe");
                    // EasyLoading.showError("Unable to complete previous option due to low memory");
                  } else {
                    if (value.isNotEmpty) {
                      XFile? image = value[0];
                      if (image != null) {
                        imageXFile = image;
                      }
                    } else {
                      setState(() {});
                    }
                  }
                },
              ),
              SizedBox(
                width: SCREEN_WIDTH(context) * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _class,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
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
                      label: const Text("Class"),
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: SCREEN_WIDTH(context) * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _subject,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
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
                      label: const Text("Subject Name"),
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: SCREEN_WIDTH(context) * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _aboutSubject,
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
                      label: const Text("About Subject"),
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: SCREEN_WIDTH(context) * 0.7,
                  child: CustomButtonWidget(
                    onPressed: () {
                      if (_subject.text == "" ||
                          imageXFile == null ||
                          _aboutSubject.text == "") {
                        dialogBox("Please fill all fields", false, false, true);
                      } else {
                        dialogBox("Please Wait...", true, false, false);
                        createSubject(_subject.text, _class.text);
                      }
                    },
                    text: "Add Category",
                    color: Color(0xffD23402),
                  )),
              SizedBox(
                height: 20,
              ),
              CustomExpansion(),
            ],
          ),
        ));
  }

  Widget CustomExpansion() {
    return ExpansionWidget(
        initiallyExpanded: false,
        titleBuilder:
            (double animationValue, _, bool isExpaned, toogleFunction) {
          return InkWell(
              onTap: () => toogleFunction(animated: true),
              child: Container(
                width: SCREEN_WIDTH(context) * 0.7,
                height: 85.h,
                decoration: BoxDecoration(
                    color: Color(0xffD23402),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 38.0),
                      child: Text(
                        'View All Subjects',
                        style: SET_FONT_STYLE(
                            30.sp, FontWeight.w400, AppColors.whiteColor),
                      ),
                    ),
                    Transform.rotate(
                      angle: math.pi * animationValue / 2,
                      child: Icon(
                        Icons.arrow_right,
                        size: 40,
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                    )
                  ],
                ),
              ));
        },
        content: SizedBox(
          width: SCREEN_WIDTH(context) * 0.7,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _extensionList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AllSubject(
                              whichClass: index <= 2
                                  ? _extensionList[index]
                                      .toString()
                                      .substring(0, 8)
                                  : _extensionList[index]
                                      .toString()
                                      .substring(0, 17),
                            ),
                          ),
                        );
                        // Get.to((context) => AllSubject(
                        //       whichClass:
                        //           _extensionList[index].toString().substring(0, 8),
                        //     ));
                      },
                      child: Container(
                        width: SCREEN_WIDTH(context) * 0.7,
                        decoration: BoxDecoration(
                            color: Color(0xffD23402),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  _extensionList[index],
                                  style: SET_FONT_STYLE(30.sp, FontWeight.w400,
                                      AppColors.whiteColor),
                                ),
                              ),
                              trailing: Icon(
                                Icons.navigate_next_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
