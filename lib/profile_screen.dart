import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shopping_app/components/profile_image.dart';
import 'package:shopping_app/components/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

// profile UI
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Center(child: Text("Profile Screen")),
            ),
            body: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    const Text("My Profile",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    ProfileImage(
                      img: const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/images/profile.png")),
                    ),
                    const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileItem(
                            isObscure: true,
                            txt: "Eman Hamad",
                            icon: Icons.person_2_outlined,
                          ),
                          ProfileItem(
                            isObscure: true,
                            txt: "eman@gmail.com",
                            icon: Icons.email_outlined,
                          ),
                          ProfileItem(
                            txt: '888888888',
                            isObscure: false,
                            icon: Icons.lock_open_outlined,
                          ),
                          ProfileItem(
                            isObscure: true,
                            txt: "01234444444",
                            icon: Icons.phone_android_outlined,
                          ),
                        ])
                  ],
                ))));
  }
}
