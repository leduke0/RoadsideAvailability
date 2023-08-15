import 'package:chop_ya/src/constants/image_strings.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/constants/text_strings.dart';
import 'package:chop_ya/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:chop_ya/src/features/core/screens/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 170,
                      height: 170,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(tProfileImage),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  tProfileHeading,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  tProfileSubHeading,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () => {
                          Get.to(() => const UpdateProfileScreen()),
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text(tEditProfile))),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),

                // Menu Section
                ProfileMenuWidget(
                  title: "Setting",
                  icon: Icons.settings,
                  onPress: () {},
                ),
                ProfileMenuWidget(
                  title: "Language",
                  icon: Icons.language_rounded,
                  onPress: () {},
                ),
                ProfileMenuWidget(
                  title: "Address",
                  icon: Icons.location_on,
                  onPress: () {},
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileMenuWidget(
                  title: "Terms and Privacy",
                  icon: Icons.health_and_safety_rounded,
                  onPress: () {},
                ),
                ProfileMenuWidget(
                  title: "Logout",
                  icon: Icons.logout,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

