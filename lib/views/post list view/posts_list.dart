import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/back_icon.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/icon_button.dart';
import 'package:reclaimify/components/post_card_widget.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/views/post%20detailed%20view/post_detailed_view.dart';
import 'package:reclaimify/views/post%20list%20view/filters.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  Uint8List? file = null;
  String? _currentItemSelected = "Gadgets";
  var _categories = ['Gadgets', 'Books', 'Id-Card', 'Bottle', 'Other Items'];
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //! <---- header -----> //
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: MyIconButton(
              onPressed: () {
                Get.to(() => FiltersView());
              },
              icon: PhosphorIcons.duotone.faders,
              text: "Filters",
            ),
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
                  height: 10.h,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    hintText: "Search based on title or description",
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w400,
                    ),

                    suffixIcon: const Icon(Icons.search),
                    // prefix: Icon(Icons.search),
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(
                            color: AppColors.slateGrey.withOpacity(0.6))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(
                            color: AppColors.slateGrey.withOpacity(0.6))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(color: AppColors.primaryBlack)),
                  ),
                ),
                SizedBox(
                  height: 10,
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
                        var data = snapshot.data!.docs[index].data();
                        if (name.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: PostCardWidget(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostDetailedView(
                                      snap: snapshot.data!.docs[index].data(),
                                    ),
                                  ),
                                );
                              },
                              snap: snapshot.data!.docs[index].data(),
                            ),
                          );
                        }
                        if (data['title']
                            .toString()
                            .toLowerCase()
                            .contains(name.toLowerCase()) || data['description']
                                .toString()
                                .toLowerCase()
                                .contains(name.toLowerCase()))  {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: PostCardWidget(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostDetailedView(
                                      snap: snapshot.data!.docs[index].data(),
                                    ),
                                  ),
                                );
                              },
                              snap: snapshot.data!.docs[index].data(),
                            ),
                          );
                        }
                        return Container();
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
