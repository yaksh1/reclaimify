import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/dual_color_text.dart';
import 'package:reclaimify/components/my_snackbar.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/services/storage/firebase_frestore_methods.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/views/post%20list%20view/posts_list.dart';

class PostReviseView extends StatefulWidget {
  PostReviseView(
      {super.key,
      required this.file,
      required this.desc,
      required this.title,
      required this.category,
      required this.postType,
      required this.location});
  final Uint8List file;
  final String desc;
  final String title;
  final String? category;
  final String postType;
  final String location;

  @override
  State<PostReviseView> createState() => _PostReviseViewState();
}

class _PostReviseViewState extends State<PostReviseView> {
  final user = AuthService.firebase().getCurrentUser();

  bool _isLoading = false;

  // //! <---- save post data -----> //
  savePostOfUser(String desc, String title, String? category, String postType,
      String location, Uint8List file, String uid) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = AuthService.firebase().getCurrentUser();
      String res = await FirestoreMethods().uploadPost(desc, file, uid,
          user!.displayName!, title, category!, location, postType);
      if (res == "Success") {
        setState(() {
          _isLoading = false;
        });
        MySnackBar().mySnackBar(
          header: "Advert Posted!",
          content: "post created successfully",
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PostsView()));
      } else {
        setState(() {
          _isLoading = false;
        });
        MySnackBar().mySnackBar(header: "res", content: "");
      }
    } catch (e) {
      MySnackBar().mySnackBar(header: "Error", content: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _isLoading
                  ? const LinearProgressIndicator(
                      color: AppColors.mainColor,
                    )
                  : Container(),
              PostReviseCard(
                  category: widget.category!,
                  desc: widget.desc,
                file: widget.file,
                  title: widget.title,
                location: widget.location,
                postType: widget.postType,

                  ),
              SizedBox(
                height: 20.h,
              ),
              //! <---- post button -----> //
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: blueButton(
                    onPressed: () {
                      savePostOfUser(
                          widget.desc,
                          widget.title,
                          widget.category,
                          widget.postType,
                          widget.location,
                          widget.file,
                          user!.uid);
                    },
                    text: "POST",
                    fontweight: FontWeight.w600,
                    height: 40.h,
                    textColor: AppColors.darkGrey,
                    color: AppColors.lightMainColor2),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class PostReviseCard extends StatelessWidget {
  const PostReviseCard({
    super.key, required this.file, required this.title, required this.desc, required this.postType, required this.category, required this.location,
  });
  final Uint8List file;
  final String title;
  final String desc;
  final String postType;
  final String category;
  final String location;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! <---- image -----> //
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(file),
              ),
            ),
          ),
          //! <---- post details -----> //
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //$ <---- title -----> //
                BigText(text: title, color: AppColors.darkGrey, size: 25),
                //$ <---- Description -----> //
                SmallText(
                  text: desc,
                  weight: FontWeight.w300,
                ),
                SizedBox(
                  height: 10.h,
                ),
                //$ <---- post type -----> //
                postDetails(
                  text1: "Type: ",
                  text2: postType,
                ),
                SizedBox(
                  height: 5.h,
                ),
                //$ <---- category -----> //

                postDetails(
                  text1: "Category: ",
                  text2: category!,
                ),
                SizedBox(
                  height: 5.h,
                ),
                //$ <---- location -----> //

                postDetails(
                  text1: "Location: ",
                  text2: location,
                ),
                SizedBox(
                  height: 5.h,
                ),
                // //$ <---- date -----> //
                // postDetails(
                //   text1: "Date Found: ",
                //   text2: "today",
                // ),
              ],
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 5.0.h),
    );
  }
}

class postDetails extends StatelessWidget {
  const postDetails({
    super.key,
    required this.text1,
    required this.text2,
  });
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return DualColorText(
      text1: text1,
      text2: text2,
      weight1: FontWeight.w600,
      weight2: FontWeight.w300,
      size: 20,
      color2: AppColors.slateGrey,
      color: AppColors.darkGrey,
    );
  }
}
