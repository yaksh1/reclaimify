// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/card.dart';
import 'package:reclaimify/components/plus_button_card.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/utils/dimensions.dart';
import 'package:reclaimify/utils/image_strings.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double width10 = Dimensions.width10;
  double height10 = Dimensions.height10;
  double radius10 = Dimensions.radius10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SmallText(text: "/Reclaimify"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width10 * 2.5),
            child: Wrap(
              // mainAxisAlignment: MainAxisAlignment.center,
              runSpacing: height10 * 2.5,
              children: [
                //! hello user
                Row(
                  children: [
                    Column(
                      children: [
                        SmallText(
                          text: "Hello,",
                          color: AppColors.darkGrey,
                          alignment: TextAlign.start,
                        ),
                        SmallText(
                          text: "Yaksh",
                          color: AppColors.darkGrey,
                          // size: width10 * 2,
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
                  onPressed: () {},
                ),
                //
                card(
                  cardColor: AppColors.lightYellow,
                  path: itemsSvg,
                  heading: "Lost & Found Items",
                  subHeading: "Go through the lost and found items list",
                  onTap: () {}, //!
                ),

                GestureDetector(
                  onTap: () {},//!
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
