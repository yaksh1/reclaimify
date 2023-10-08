import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/views/post%20revise%20view/post_revise.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({super.key, required this.snap, required this.onPressed});
  final snap;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Hero(
        tag: 'hello',
        child: Card(
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
                    image: NetworkImage(snap['postUrl']),
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
                    BigText(
                        text: snap["title"], color: AppColors.darkGrey, size: 25),
                    //$ <---- Description -----> //
                    SmallText(
                      text: snap["description"],
                      weight: FontWeight.w300,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    //$ <---- post type -----> //
                    postDetails(
                      text1: "Type: ",
                      text2: snap["postType"],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    //$ <---- category -----> //
      
                    postDetails(
                      text1: "Category: ",
                      text2: snap["category"],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    //$ <---- location -----> //
      
                    postDetails(
                      text1: "Location: ",
                      text2: snap["location"],
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
        ),
      ),
    );
  }
}
