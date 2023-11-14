import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/my_snackbar.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/views/authentication/login/login_view.dart';
import 'package:reclaimify/views/profile%20view/profile_view.dart';

class DrawerView extends StatelessWidget {
  DrawerView({super.key});

  final currentUser = AuthService.firebase().getCurrentUser()!;
  @override
  Widget build(BuildContext context) {
    var url = currentUser.photoURL ??
        "https://images.unsplash.com/photo-1543946602-a0fce8117697?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8bmV0d29ya3xlbnwwfHwwfHx8MA%3D%3D";

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Row(
          children: [
            //! <---- profile image -----> //
            Hero(
              tag: 'hero',
              child: CircleAvatar(
                  radius: 40,
                  backgroundImage: CachedNetworkImageProvider(
                    url,
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            //TODO add number too
            // Column(
            //   children: [
            //     BigText(
            //       text: currentUser.displayName!,
            //       color: AppColors.primaryBlack,
            //       size: 20,
            //     ),
            //   ],
            // )
          ],
        ),
        actions: [
          // Padding(
          //   padding:EdgeInsets.only(left: 100),
          //   child: SmallText(text: "/Reclaimify")),
          //! <---- cross icon -----> //
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Icon(
                PhosphorIcons.regular.x,
                size: 35.r,
                color: AppColors.slateGrey,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: Column(
            children: [
              //! <---- profile -----> //
              UserProfile(),
              
              SizedBox(
                height: 10,
              ),
              //! <---- messages -----> //
              BigText(
                text: "Messages",
                color: AppColors.darkGrey,
                size: 30,
              ),
              SizedBox(
                height: 10,
              ),
              //! <---- about us -----> //
              BigText(
                text: "About Us",
                color: AppColors.darkGrey,
                size: 30,
              ),
              SizedBox(
                height: 10,
              ),
              //! <---- contact us -----> //
              BigText(
                text: "Contact Us",
                color: AppColors.darkGrey,
                size: 30,
              ),
              SizedBox(
                height: 10,
              ),
              //! <---- settings -----> //
              BigText(
                text: "Settings",
                color: AppColors.darkGrey,
                size: 30,
              ),
              SizedBox(
                height: 10,
              ),

              //! <---- logout -----> //
              LogoutFunction(),
            ],
          ),
        ),
      )),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileView(),
            ),
          );
        },
        child: BigText(
          text: "My Profile",
          color: AppColors.darkGrey,
          size: 30,
        ));
  }
}

class LogoutFunction extends StatelessWidget {
  const LogoutFunction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final shouldLogout = await showLogOutDiaglog(context);
        if (shouldLogout) {
          await AuthService.firebase().logOut();
          final snackbar = MySnackBar();
          snackbar.mySnackBar(
              header: "Logged out!",
              content: "see you soon",
              bgColor: Colors.green.shade100,
              borderColor: Colors.green);
          Get.to(() => LoginView());
        }
      },
      child: BigText(
        text: "Logout",
        color: AppColors.darkGrey,
        size: 30,
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
