import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/back_icon.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/icon_button.dart';
import 'package:reclaimify/components/post_card_widget.dart';
import 'package:reclaimify/utils/colors.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  Uint8List? file = null;
  String? _currentItemSelected = "Gadgets";
  var _categories = ['Gadgets', 'Books', 'Id-Card', 'Bottle', 'Other Items'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //! <---- header -----> //
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(Icons.search_sharp, size: 35.h),
          ),
        ],
        centerTitle: true,
        leading: BackIcon(),
        // centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    //! <---- select category -----> //
                    Expanded(child: _selectionCategory()),
                    SizedBox(
                      width: 16,
                    ),
                    //! <---- icon button filters -----> //
                    MyIconButton(
                      onPressed: () {
                        //TODO
                      },
                      icon: PhosphorIcons.duotone.faders,
                      text: "Filters",
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical:24),
                          child: PostCardWidget(
                            snap: snapshot.data!.docs[index].data(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  //! <---- select a category -----> //
  Container _selectionCategory() {
    return Container(
      height: 50.h,
      width: 210.w,
      alignment: Alignment.centerLeft,
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
          onChanged: (String? newValueSelected) {
            setState(() {
              _currentItemSelected = newValueSelected;
            });
          },
          value: _currentItemSelected,
        ),
      ),
    );
  }
}
