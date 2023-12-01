import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reclaimify/components/back_icon.dart';
import 'package:reclaimify/components/big_tex.dart';
import 'package:reclaimify/components/icon_with_circle.dart';
import 'package:reclaimify/components/small_text.dart';
import 'package:reclaimify/services/auth/auth_service.dart';
import 'package:reclaimify/utils/colors.dart';
import 'package:reclaimify/views/authentication/phone%20enter%20view/phone_login_verification.dart';
import 'package:reclaimify/views/post%20detailed%20view/post_detailed_view.dart';
import 'package:reclaimify/views/profile%20view/widgets/profile_post_card.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final currentUser = AuthService.firebase().getCurrentUser()!;
  var phone = '';
  void getPhone() async {
    var collection = FirebaseFirestore.instance.collection('phoneNumbers');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();

      phone = data['phoneNumber'];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhone();
  }

  @override
  Widget build(BuildContext context) {
    getPhone();
    var url = currentUser.photoURL ??
        "https://images.unsplash.com/photo-1543946602-a0fce8117697?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8bmV0d29ya3xlbnwwfHwwfHx8MA%3D%3D";

    return Scaffold(
      appBar: AppBar(
        leading: BackIcon(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Hero(
                tag: 'hero',
                child: CircleAvatar(
                    radius: 60,
                    backgroundImage: CachedNetworkImageProvider(
                      url,
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
              InkWell(
                  onTap: () {
                    Get.to(() => PhoneLoginVerification());
                  },
                  child: ProfileCardWidget(currentUser: currentUser, phone: phone,)),
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
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('posts')
                    .where('username', isEqualTo: currentUser.displayName)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: ProfilePostCard(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailedView(
                                  snap: snapshot.data!.docs[index].data(),
                                ),
                              ),
                            );
                          },
                          snap: snapshot.data!.docs[index].data(),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

//$ <---- user details on card -----> //
class ProfileCardWidget extends StatelessWidget {
  ProfileCardWidget({
    super.key,
    required this.currentUser, required this.phone,
  });

  final User currentUser;
  final String phone;

  @override
  Widget build(BuildContext context) {
    String text = phone == '' ? "Click to add phone number" : phone;
    return Card(
      elevation: 6,
      color: AppColors.grey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ProfileCardItems(icon: PhosphorIcons.regular.phoneCall, text: text),
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
              icon: PhosphorIcons.regular.envelope, text: currentUser.email!),
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
              icon: PhosphorIcons.regular.instagramLogo, text: "@instagram"),
        ]),
      ),
    );
  }
}

//$ <---- items in user details card -----> //
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
        IconWithCircle(icon: icon),
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
