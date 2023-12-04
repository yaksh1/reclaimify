import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reclaimify/components/back_icon.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/my_snackbar.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/components/text_form.dart';
import 'package:reclaimify/components/text_form_description.dart';
import 'package:reclaimify/components/text_form_title.dart';
import 'package:reclaimify/utils/colors.dart';

import 'package:reclaimify/views/take%20image%20view/image_option_view.dart';

class AdvertView extends StatefulWidget {
  const AdvertView({super.key, required this.isEdit, this.snap});
  final bool isEdit;
  final snap;
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
    super.initState();
    _title = TextEditingController();
    _desc = TextEditingController();
    _location = TextEditingController();

    bool isEdit = widget.isEdit;
    if (isEdit) {
      final title = widget.snap['title'];
      final desc = widget.snap['description'];
      final location = widget.snap['location'];
      final oldPostType = widget.snap['postType'];
      final category = widget.snap['category'];
      _title.text = title;
      _desc.text = desc;
      _location.text = location;
      if (oldPostType == "Lost") {
        _shadow3 = Colors.red.shade200;
        _shadow4 = AppColors.lightRed;
        _shadow1 = Colors.transparent;
        _shadow2 = Colors.transparent;
      } else {
        _shadow1 = Colors.blue.shade200;
        _shadow2 = AppColors.lightMainColor2;
        _shadow3 = Colors.transparent;
        _shadow4 = Colors.transparent;
      }
      _currentItemSelected = category;
    }
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
          widget.isEdit ? "Edit Post" : "Create a Post",
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
                    TextFormTitle(
                      helperText:
                          "Title must be less than or equal to 15 characters",
                      label: "Title",
                      hintText: "Enter the title of the Ad",
                      obscureText: false,
                      controller: _title,
                    ),

                    SizedBox(
                      height: 15.h,
                    ),

                    //* <---- description header -----> //
                    _buildHeader("Description"),

                    SizedBox(
                      height: 10.h,
                    ),

                    //! <---- description field -----> //
                    TextFormDescription(
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
                                        isEdit: widget.isEdit,
                                        snap: widget.snap,
                                      ));
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
          decoration: BoxDecoration(
            boxShadow: [
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
            ],
          ),
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
