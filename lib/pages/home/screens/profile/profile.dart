import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:keeper/pages/home/screens/profile/widgets/profile_btn.dart';
import "package:keeper/core/widgets/ui/app_icon.dart";

class Profile extends GetView {
  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: AppIcon(HugeIcons.strokeRoundedMenu01),
        ),
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: AppIcon(HugeIcons.strokeRoundedNotification01),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 20, top: 10, bottom: 10),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: Get.width * 0.07,
              children: [
                Container(
                  width: Get.width * 0.15,
                  height: Get.width * 0.15,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Get.width * 0.2),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 1,
                        color: Colors.grey.shade300,
                      ),

                      BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 1,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "HK",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Git fanny",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Git fanny",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileBtn(
                  clickHandler: () {},
                  label: "Account Settings",
                  icon: HugeIcons.strokeRoundedProfile,
                ),

                ProfileBtn(
                  clickHandler: () {},
                  label: "Privacy Policy",
                  icon: HugeIcons.strokeRoundedShield01,
                ),
                ProfileBtn(
                  clickHandler: () {},
                  label: "Terms of Service",
                  icon: HugeIcons.strokeRoundedLegalDocument02,
                ),
                ProfileBtn(
                  clickHandler: () {},
                  label: "Support",
                  icon: HugeIcons.strokeRoundedHelpSquare,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),

                    child: Row(
                      spacing: Get.width * 0.07,
                      children: [
                        AppIcon(
                          Icons.logout_outlined,
                          size: 25,
                          color: Colors.red,
                        ),
                        Text(
                          "Log out",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
