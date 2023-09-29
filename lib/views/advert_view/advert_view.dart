import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/my_text_field.dart';
import 'package:reclaimify/components/small_text.dart';
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

  //$ <---- my controllers -----> //
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _location = TextEditingController();

  //$ <---- my box shadows -----> //
  Color _shadow1 = Colors.transparent;
  Color _shadow2 = Colors.transparent;
  Color _shadow3 = Colors.transparent;
  Color _shadow4 = Colors.transparent;

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

  String? _currentItemSelected = "Gadgets";
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
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            PhosphorIcons.duotone.caretCircleLeft,
            size: 40,
          ),
        ),
        // centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    height: 25.h,
                  ),

                  //* --- post type header --- //
                  _buildHeader("Post Type"),

                  SizedBox(
                    height: 10.h,
                  ),

                  //! <---- post type selection -----> //
                  _postTypeSelection(),

                  SizedBox(
                    height: 25.h,
                  ),

                  //* <---- title header -----> //
                  _buildHeader("Title"),

                  SizedBox(
                    height: 10.h,
                  ),

                  //! <---- title field -----> //
                  MyTextField(
                    hintText: "Title",
                    controller: _title,
                  ),

                  SizedBox(
                    height: 25.h,
                  ),

                  //* <---- description header -----> //
                  _buildHeader("Description"),

                  SizedBox(
                    height: 10.h,
                  ),

                  //! <---- description field -----> //
                  MyTextField(
                    hintText: "Description",
                    controller: _desc,
                  ),

                  SizedBox(
                    height: 25.h,
                  ),

                  //* <---- Location header -----> //
                  _buildHeader("Location"),

                  SizedBox(
                    height: 10.h,
                  ),

                  //! <---- location field -----> //
                  MyTextField(
                    hintText: "Location",
                    controller: _location,
                  ),

                  SizedBox(
                    height: 35.h,
                  ),

                  //! <---- continue button -----> //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      blueButton(
                          onPressed: () {
                            //TODO: selection
                            Get.off(() => ImageOptions());
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
          ]),
          child: blueButton(
              onPressed: () {
                setState(() {
                  _shadow1 = Colors.blue.shade200;
                  _shadow2 = AppColors.lightMainColor2;
                  _shadow3 = Colors.transparent;
                  _shadow4 = Colors.transparent;
                });
                //TODO: selection
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