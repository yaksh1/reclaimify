import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/back_icon.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/icon_and_text.dart';
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
      body:  Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            Hero(
              tag: 'hero',
              child: CircleAvatar(
                  radius: 60,
                  backgroundImage: CachedNetworkImageProvider(
                    currentUser.photoURL!,
                  )),
            ),
            SizedBox(height: 12,),
            BigText(text: currentUser.displayName!, color: AppColors.darkGrey,size:32 ,),
        
            Card(
              color: AppColors.grey,
              
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  IconAndTextWidget(icon: PhosphorIcons.regular.phoneCall, text: "+91xxxxxxxxxx", iconColor: AppColors.slateGrey, textColor: AppColors.darkGrey,alignment: MainAxisAlignment.start,),
                    IconAndTextWidget(
                        icon: PhosphorIcons.regular.envelope,
                        text: currentUser.email!,
                        iconColor: AppColors.slateGrey,
                        textColor: AppColors.darkGrey,
                        alignment: MainAxisAlignment.start
                        ),
                  IconAndTextWidget(
                        icon: PhosphorIcons.regular.instagramLogo,
                        text: "@instagram",
                        iconColor: AppColors.slateGrey,
                        textColor: AppColors.darkGrey,
                        alignment: MainAxisAlignment.start
                        ),
                  
                ]),
              ),
            )
          ],
          
          ),
        
      ),
    );
  }
}
