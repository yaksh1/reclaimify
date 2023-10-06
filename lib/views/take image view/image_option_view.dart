import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/pick_image.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/views/post%20revise%20view/post_revise.dart';

class ImageOptions extends StatefulWidget {
  const ImageOptions(
      {super.key,
      required this.desc,
      required this.title,
      required this.category,
      required this.postType,
      required this.location});
  final String desc;
  final String title;
  final String? category;
  final String postType;
  final String location;
  @override
  State<ImageOptions> createState() => _ImageOptionsState();
}

class _ImageOptionsState extends State<ImageOptions> {
  Uint8List? _file;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 130.h),
              child: Column(
                children: [
                  //! upload an image
                  PlusCard(
                    onPressed: () async {
                      Uint8List image = await pickImage(ImageSource.camera);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostReviseView(
                                  category: widget.category,
                                  desc: widget.desc,
                                  location: widget.location,
                                  postType: widget.postType,
                                  title: widget.title,
                                  file: _file!,
                                )),
                      );
                      setState(() {
                        _file = image;
                      });
                    },
                    title: "Take an image",
                    subtitle: "Take image using camera",
                    plusColor: AppColors.mainColor,
                    cardColor: AppColors.lightMainColor2,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  PlusCard(
                    onPressed: () async {
                      Uint8List image = await pickImage(ImageSource.gallery);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostReviseView(
                                  category: widget.category,
                                  desc: widget.desc,
                                  location: widget.location,
                                  postType: widget.postType,
                                  title: widget.title,
                                  file: _file!,
                                )),
                      );
                      setState(() {
                        _file = image;
                      });
                    },
                    title: "Upload an image",
                    subtitle: "upload image from your local gallery",
                    plusColor: Colors.red.shade500,
                    cardColor: AppColors.lightRed,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlusCard extends StatelessWidget {
  const PlusCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.plusColor,
    required this.cardColor,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final Color plusColor;
  final Color cardColor;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 350.w,
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 17.h),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
            color: cardColor, borderRadius: BorderRadius.circular(20)),
        // padding: EdgeInsets.only(bottom: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 165.h,
              width: 70.w,
              child: MaterialButton(
                elevation: 7,
                onPressed: onPressed,
                textColor: plusColor,
                color: AppColors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r)),
                height: 60.h,
                child: Icon(
                  PhosphorIcons.bold.plus,
                  size: 35,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: [
                BigText(
                  text: title,
                  color: AppColors.darkGrey,
                  size: 25,
                ),
                SmallText(
                  text: subtitle,
                  size: 10.sp,
                  color: AppColors.smallText,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
