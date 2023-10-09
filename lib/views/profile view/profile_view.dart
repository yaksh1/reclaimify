import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/back_icon.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/icon_and_text.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final currentUser = AuthService.firebase().getCurrentUser()!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackIcon(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Hero(
              tag: 'hero',
              child: CircleAvatar(
                  radius: 60,
                  backgroundImage: CachedNetworkImageProvider(
                    currentUser.photoURL!,
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            BigText(
              text: currentUser.displayName!,
              color: AppColors.darkGrey,
              size: 32,
            ),
            SizedBox(
              height: 24,
            ),
            ProfileCardWidget(currentUser: currentUser),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                BigText(
                  text: "Your Posts",
                  color: AppColors.darkGrey,
                  size: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({
    super.key,
    required this.currentUser,
  });

  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: AppColors.grey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 12.0, vertical: 12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileCardItems(
                  icon: PhosphorIcons.regular.phoneCall,
                  text: "+91xxxxxxxxxx"),
              SizedBox(
                height: 12.h,
              ),
              Divider(
                height: 4,
                color: AppColors.slateGrey,
              ),
              SizedBox(
                height: 12.h,
              ),
              ProfileCardItems(
                  icon: PhosphorIcons.regular.envelope,
                  text: currentUser.email!),
              SizedBox(
                height: 12.h,
              ),
              Divider(
                height: 4,
                color: AppColors.slateGrey,
              ),
              SizedBox(
                height: 12.h,
              ),
              ProfileCardItems(
                  icon: PhosphorIcons.regular.instagramLogo,
                  text: "@instagram"),
            ]),
      ),
    );
  }
}

class ProfileCardItems extends StatelessWidget {
  const ProfileCardItems({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.slateGrey),
              borderRadius: BorderRadiusDirectional.circular(50)),
          child: Icon(
            icon,
            color: AppColors.slateGrey,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        SmallText(
          text: text,
          color: AppColors.darkGrey,
        ),
      ],
    );
  }
}
