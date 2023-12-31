import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/back_icon.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/blue_button.dart';
import 'package:reclaimify/components/icon_and_text.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/text_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailedView extends StatefulWidget {
  const PostDetailedView({super.key, required this.snap});
  final snap;

  @override
  State<PostDetailedView> createState() => _PostDetailedViewState();
}

class _PostDetailedViewState extends State<PostDetailedView> {
  //! <---- get phone number -----> //
  var phone = '';
  Future<void> getPhoneUser(String uid) async {
    final String _phone = await AuthService.firebase().getPhone(uid: uid);
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        phone = _phone;
      });
    });

    Logger().d(phone);
  }

  void whatsappLauncher({required phone, required message}) async {
    phone = Uri.encodeComponent(phone);
    String url = "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    Uri urlLink = Uri.parse(url);
    Logger().d(phone);
    await canLaunchUrl(urlLink) ? launchUrl(urlLink) : Logger().d("error");
  }

  void callLauncher({required phone}) async {
    String url = "tel:+91${phone}";
    Uri urlLink = Uri.parse(url);
    await canLaunchUrl(urlLink) ? launchUrl(urlLink) : Logger().d("error");
  }

  final user = AuthService.firebase().getCurrentUser()!;
  dynamic data;

  // Future<dynamic> getData() async {
  //   final Query<Map<String, dynamic>> document = FirebaseFirestore.instance
  //       .collection("users")
  //       .where('username', isEqualTo: widget.snap['username']);

  //   await document.get().then<dynamic>((QuerySnapshot snapshot) async {
  //     setState(() {
  //       data = snapshot.docs;
  //       Logger().d(data);
  //     });
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhoneUser(widget.snap['uid']);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          // alignment: Alignment.topLeft,
          children: [
            //! <---- Image -----> //
            Container(
              height: 510,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  imageUrl: widget.snap['postUrl'],
                  // height: 200,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SafeArea(child: BackIcon()),
            Padding(
              padding: const EdgeInsets.only(top: 400.0),
              child: Container(
                width: double.infinity,
                height: 700,
                decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      //! <---- user name -----> //
                      SmallText(
                        text: "Ad Posted by ${widget.snap['username']}",
                        color: AppColors.darkGrey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //! <---- ad title -----> //
                          BigText(
                              text: widget.snap['title'],
                              color: AppColors.darkGrey),
                          // //! <---- share option -----> //
                          // Icon(
                          //   PhosphorIcons.duotone.shareNetwork,
                          //   color: AppColors.darkGrey,
                          //   size: 30,
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      //! <---- description -----> //
                      SmallText(
                        text: widget.snap["description"],
                        weight: FontWeight.w300,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      //! <---- location -----> //
                      IconAndTextWidget(
                        width: 10.w,
                        alignment: MainAxisAlignment.start,
                        icon: PhosphorIcons.duotone.mapPin,
                        text: widget.snap['location'],
                        iconColor: AppColors.slateGrey,
                        textColor: AppColors.slateGrey,
                        weight: FontWeight.w300,
                      ),

                      SizedBox(
                        height: 6.h,
                      ),
                      //! <---- post type -----> //
                      IconAndTextWidget(
                        width: 10.w,
                        alignment: MainAxisAlignment.start,
                        icon: PhosphorIcons.duotone.archive,
                        text: widget.snap['postType'],
                        iconColor: AppColors.slateGrey,
                        textColor: AppColors.slateGrey,
                        weight: FontWeight.w300,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      //! <---- category -----> //
                      IconAndTextWidget(
                        width: 10.w,
                        alignment: MainAxisAlignment.start,
                        icon: PhosphorIcons.duotone.boundingBox,
                        text: widget.snap['category'],
                        iconColor: AppColors.slateGrey,
                        textColor: AppColors.slateGrey,
                        weight: FontWeight.w300,
                      ),
                      //! <---- date -----> //
                      //TODO date format
                      // IconAndTextWidget(
                      //   width: 0,
                      //   alignment: MainAxisAlignment.start,
                      //   icon: PhosphorIcons.duotone.mapPin,
                      //   text: widget.snap['location'],
                      //   iconColor: AppColors.slateGrey,
                      //   textColor: AppColors.slateGrey,
                      //   weight: FontWeight.w300,
                      // ),
                      //! <---- call and message button -----> //
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(top: 75.h),
                            child: Row(
                              children: [
                                //! <---- call button -----> //
                                InkWell(
                                  onTap: () {
                                    callLauncher(phone: phone);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.mainColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      PhosphorIcons.duotone.phoneCall,
                                      color: AppColors.mainColor,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                //! <---- message button -----> //
                                Expanded(
                                    child: blueButton(
                                  onPressed: () {
                                    whatsappLauncher(
                                        phone: phone,
                                        message:
                                            widget.snap['postType'] == "Lost"
                                                ? lostString
                                                : foundString);
                                  },
                                  text: "Message ->",
                                  color: AppColors.lightMainColor2,
                                  height: 46,
                                  textColor: AppColors.darkGrey,
                                  fontweight: FontWeight.w600,
                                  fontSize: 24,
                                ))
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
