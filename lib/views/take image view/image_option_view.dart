import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/utils/colors.dart';

class ImageOptions extends StatefulWidget {
  const ImageOptions({super.key});

  @override
  State<ImageOptions> createState() => _ImageOptionsState();
}

class _ImageOptionsState extends State<ImageOptions> {
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
                    title: "Upload an image",
                    subtitle: "upload image from your local gallery",
                    plusColor: AppColors.mainColor,
                    cardColor: AppColors.lightMainColor2,
                  ),
                  SizedBox(height: 30.h,),
                  PlusCard(
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
  });

  final String title;
  final String subtitle;
  final Color plusColor;
  final Color cardColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 350.w,
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 17.h),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: cardColor, borderRadius: BorderRadius.circular(20)),
        // padding: EdgeInsets.only(bottom: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 165.h,
              width: 70.w,
              child: MaterialButton(
                elevation: 7,
                onPressed: () {},
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
            Column(
              children: [
                BigText(
                  text: title,
                  color: AppColors.darkGrey,
                  size: 30,
                ),
                SmallText(
                  text: subtitle,
                  size: 12.sp,
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
