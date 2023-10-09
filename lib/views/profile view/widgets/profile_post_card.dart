import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/icon_and_text.dart';
import 'package:reclaimify/components/icon_with_circle.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/services/storage/firebase_frestore_methods.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/views/post%20revise%20view/post_revise.dart';

class ProfilePostCard extends StatefulWidget {
  const ProfilePostCard(
      {super.key, required this.snap, required this.onPressed});
  final snap;
  final VoidCallback onPressed;

  @override
  State<ProfilePostCard> createState() => _ProfilePostCardState();
}

class _ProfilePostCardState extends State<ProfilePostCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
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
                  image: NetworkImage(widget.snap['postUrl']),
                ),
              ),
            ),

            //! <---- post details -----> //
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //$ <---- title -----> //
                      BigText(
                          text: widget.snap["title"],
                          color: AppColors.darkGrey,
                          size: 25),
                      //$ <---- dot icon -----> //
                      InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              //$ <---- bottom sheet -----> //
                              return bottomSheet(id: widget.snap['postId']);
                            },
                          );
                        },
                        child: Icon(
                          PhosphorIcons.bold.dotsThreeVertical,
                          color: AppColors.darkGrey,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  //$ <---- Description -----> //
                  SmallText(
                    text: widget.snap["description"],
                    weight: FontWeight.w300,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  //$ <---- post type -----> //
                  postDetails(
                    text1: "Type: ",
                    text2: widget.snap["postType"],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  //$ <---- category -----> //

                  postDetails(
                    text1: "Category: ",
                    text2: widget.snap["category"],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  //$ <---- location -----> //

                  postDetails(
                    text1: "Location: ",
                    text2: widget.snap["location"],
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
    );
  }
}

class bottomSheet extends StatefulWidget {
  const bottomSheet({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<bottomSheet> createState() => _bottomSheetState();
}

class _bottomSheetState extends State<bottomSheet> {
  bool isPostDeleted = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.grey,
      ),
      height: 210,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //TODO: onPressed for all items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconWithCircle(
                  icon: PhosphorIcons.regular.shareNetwork,
                  color: AppColors.darkGrey,
                  padding: 12,
                  iconSize: 28,
                ),
                IconWithCircle(
                  icon: PhosphorIcons.regular.copy,
                  color: AppColors.darkGrey,
                  padding: 12,
                  iconSize: 28,
                ),
                InkWell(
                  onTap: () async {
                    setState(() {
                      isPostDeleted = true;
                    });
                    await FirestoreMethods().deletePost(widget.id);
                    Navigator.of(context).pop();
                  },
                  child: IconWithCircle(
                    icon: PhosphorIcons.regular.trash,
                    color: Colors.red,
                    padding: 12,
                    iconSize: 28,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Divider(
              height: 4,
              color: AppColors.slateGrey,
            ),
            SizedBox(
              height: 16.h,
            ),

            Row(
              children: [
                IconAndTextWidget(
                  icon: PhosphorIcons.regular.pen,
                  text: "Edit",
                  iconColor: AppColors.darkGrey,
                  textColor: AppColors.darkGrey,
                  fontSize: 24,
                  iconSize: 32,
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                IconAndTextWidget(
                  icon: Icons.verified_user_outlined,
                  text: "Owner Found",
                  iconColor: AppColors.darkGrey,
                  textColor: AppColors.darkGrey,
                  fontSize: 24,
                  iconSize: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
