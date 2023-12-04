// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/card.dart';
import 'package:reclaimify/components/plus_button_card.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:reclaimify/utils/text_strings.dart';
import 'package:reclaimify/views/Drawer%20view/drawer_view.dart';
import 'package:reclaimify/views/advert_view/advert_view.dart';
import 'package:reclaimify/views/post%20list%20view/posts_list.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    super.key,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final currentUser = AuthService.firebase().getCurrentUser();

  //! <---- getuser name -----> //
  String name = "";
  Future<void> getUserName() async {
    final String _name = await AuthService.firebase().getName();
    setState(() {
      name = currentUser?.displayName ?? _name;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  double width10 = Dimensions.width10;
  double height10 = Dimensions.height10;
  double radius10 = Dimensions.radius10;
  @override
  Widget build(BuildContext context) {
    var url = currentUser?.photoURL ?? defaultUser;
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DrawerView(),
              ),
            );
          },
          child: Hero(
            tag: 'hero',
            child:
                CircleAvatar(backgroundImage: CachedNetworkImageProvider(url)),
          ),
        ),

        // centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width10 * 2.5),
            child: Wrap(
              // mainAxisAlignment: MainAxisAlignment.center,
              runSpacing: height10 * 2,
              children: [
                //! hello user
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: "Hello,",
                          color: AppColors.darkGrey,
                          alignment: TextAlign.start,
                        ),
                        SmallText(
                          text: name,
                          color: AppColors.darkGrey,
                          size: width10 * 2.5,
                          alignment: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),

                //! advert for item
                PlusButtonCard(
                  subHeading: 'Find your item or report a lost item',
                  cardColor: AppColors.lightMainColor2,
                  heading: "Create an advert",
                  icon: Icon(
                    PhosphorIcons.bold.plus,
                    size: height10 * 4,
                  ),
                  onPressed: () {
                    Get.to(() => AdvertView(isEdit: false,));
                  },
                ),
                //
                card(
                  cardColor: AppColors.lightYellow,
                  path: itemsSvg,
                  heading: "Lost & Found Items",
                  subHeading: "Go through the lost and found items list",
                  onTap: () {
                    Get.to(() => PostsView());
                  },
                ),

                GestureDetector(
                  onTap: () {}, //TODO
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: height10 * 1.7, horizontal: width10 * 1.5),
                    height: height10 * 19,
                    width: width10 * 35,
                    decoration: BoxDecoration(
                      color: AppColors.mapColor,
                      borderRadius: BorderRadius.circular(radius10 * 1.9),
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          mapSvg,
                          height: height10 * 5,
                        ),
                        SizedBox(
                          height: height10 * 1.5,
                        ),
                        BigText(
                          text: "Find on map",
                          color: AppColors.darkGrey,
                          size: width10 * 2.5,
                        ),
                        SmallText(
                          text: "Search for items on nearby locations",
                          size: width10 * 1.5,
                          color: AppColors.smallText,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> showLogOutDiaglog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("cancel")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("yes")),
        ],
      );
    },
  ).then((value) => value ?? false);
}
