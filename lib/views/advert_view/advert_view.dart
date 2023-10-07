import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reclaimify/components/back_icon.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/my_snackbar.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/components/text_form.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';

import 'package:reclaimify/views/take%20image%20view/image_option_view.dart';

class AdvertView extends StatefulWidget {
  const AdvertView({super.key});

  @override
  State<AdvertView> createState() => _AdvertViewState();
}

class _AdvertViewState extends State<AdvertView> {
  //$ <---- list of categories -----> //
  var _categories = ['Gadgets', 'Books', 'Id-Card', 'Bottle', 'Other Items'];
  String? _currentItemSelected = "Gadgets";

  //! <---- global key -----> //
  final _formKey = GlobalKey<FormState>();

  //$ <---- my controllers -----> //
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _location = TextEditingController();

  //$ <---- my box shadows -----> //
  Color _shadow1 = Colors.transparent;
  Color _shadow2 = Colors.transparent;
  Color _shadow3 = Colors.transparent;
  Color _shadow4 = Colors.transparent;

  String postType = "found";

  @override
  void initState() {
    _title = TextEditingController();
    _desc = TextEditingController();
    _location = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _title = TextEditingController();
    _desc = TextEditingController();
    _location = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //! <---- header -----> //
        title: Text(
          "Create a Post",
          style: TextStyle(
              color: AppColors.darkGrey,
              fontWeight: FontWeight.w800,
              fontSize: 40),
        ),
        centerTitle: true,
        leading: BackIcon(),
        // centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //! <---- category -----> //
                    SizedBox(
                      height: 20.h,
                    ),
                    _buildHeader("Category"),
                    SizedBox(
                      height: 10.h,
                    ),
                    //! <---- select category -----> //
                    _selectionCategory(),

                    SizedBox(
                      height: 15.h,
                    ),

                    //* --- post type header --- //
                    _buildHeader("Post Type"),

                    SizedBox(
                      height: 10.h,
                    ),

                    //! <---- post type selection -----> //
                    _postTypeSelection(),

                    SizedBox(
                      height: 15.h,
                    ),

                    //* <---- title header -----> //
                    _buildHeader("Title"),

                    SizedBox(
                      height: 10.h,
                    ),

                    //! <---- title field -----> //
                    TextForm(
                      helperText: "",
                      label: "Title",
                      hintText: "Enter the title of the Ad",
                      obscureText: false,
                      controller: _title,
                    ),

                SizedBox(
                      height: 10.h,
                    ),

                    //* <---- description header -----> //
                    _buildHeader("Description"),

                    SizedBox(
                      height: 10.h,
                    ),

                    //! <---- description field -----> //
                    TextForm(
                      helperText: "Eg. color,brand,item name,building/room no.",
                      label: "Description",
                      hintText: "Enter description of the item",
                      obscureText: false,
                      controller: _desc,
                    ),

                    SizedBox(
                      height: 15.h,
                    ),

                    //* <---- Location header -----> //
                    _buildHeader("Location"),

                    SizedBox(
                      height: 10.h,
                    ),

                    //! <---- location field -----> //
                    TextForm(
                      helperText: "Area, near by building name",
                      label: "Location",
                      hintText: "Enter location",
                      obscureText: false,
                      controller: _location,
                    ),

                    SizedBox(
                      height: 25.h,
                    ),

                    //! <---- continue button -----> //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        blueButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                try {
                                Get.to(() => ImageOptions(
                                      category: _currentItemSelected,
                                      desc: _desc.text,
                                      location: _location.text,
                                      postType: postType,
                                      title: _title.text,
                                    )
                                    );
                                } catch (e) {
                                  MySnackBar().mySnackBar(
                                      header: "Error", content: e.toString());
                                }
                              }
                              // savePostOfUser(_desc.text, _title.text,
                              //     _currentItemSelected, postType, _location.text);
                            },
                            text: "Continue ->",
                            width: 150.w,
                            fontweight: FontWeight.w600,
                            height: 40.h,
                            textColor: AppColors.darkGrey,
                            color: AppColors.lightMainColor2),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //! <---- save post data -----> //
  savePostOfUser(String desc, String title, String? category, String postType,
      String location) {
    final user = AuthService.firebase().getCurrentUser();
    FirebaseFirestore.instance.collection("Posts").doc(user!.email).set({
      'email': user.email,
      'name': user.displayName,
      'category': category,
      'post Type': postType,
      'description': desc,
      'title': title,
      'location': location,
    });
  }

  //! <---- build header method -----> //
  Row _buildHeader(String title) {
    return Row(
      children: [
        //* ---category header --- //
        SmallText(
          text: title,
          color: AppColors.darkGrey,
          weight: FontWeight.w600,
          size: 16.sp,
        ),
      ],
    );
  }

  //! <---- select a category -----> //
  Container _selectionCategory() {
    return Container(
      height: 50.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
          // <---- fill color -----> //
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
              // <---- border color -----> //
              color: AppColors.slateGrey.withOpacity(0.6),
              width: 2)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          iconSize: 30.h,
          style: TextStyle(
              // <---- text color -----> //
              color: AppColors.slateGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
          items: _categories.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          isExpanded: true,
          onChanged: (String? newValueSelected) {
            _onDropDwnItemSelected(newValueSelected);
          },
          value: _currentItemSelected,
        ),
      ),
    );
  }

  //! <---- method for post selection -----> //
  Row _postTypeSelection() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: _shadow1,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              blurRadius: 20,
              color: _shadow2,
              offset: Offset(0, 4),
            ),
          ],),
          child: blueButton(
              onPressed: () {
                setState(() {
                  _shadow1 = Colors.blue.shade200;
                  _shadow2 = AppColors.lightMainColor2;
                  _shadow3 = Colors.transparent;
                  _shadow4 = Colors.transparent;
                  postType = "Found";
                });
              },
              text: "Found",
              width: 85.w,
              fontweight: FontWeight.w600,
              height: 40.h,
              textColor: AppColors.darkGrey,
              color: AppColors.lightMainColor2),
        ),
        SizedBox(
          width: 10.w,
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: _shadow3,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              blurRadius: 20,
              color: _shadow4,
              offset: Offset(0, 4),
            ),
          ]),
          child: blueButton(
            onPressed: () {
              setState(() {
                _shadow3 = Colors.red.shade200;
                _shadow4 = AppColors.lightRed;
                _shadow1 = Colors.transparent;
                _shadow2 = Colors.transparent;
                postType = "Lost";
              });
            },
            text: "lost",
            width: 85.w,
            fontweight: FontWeight.w600,
            height: 40.h,
            color: AppColors.lightRed,
            textColor: AppColors.darkGrey,
          ),
        )
      ],
    );
  }

  void _onDropDwnItemSelected(String? newValueSelected) {
    setState(() {
      _currentItemSelected = newValueSelected;
    });
  }
}


