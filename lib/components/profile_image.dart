import 'package:flutter/material.dart';


// image's profile component
class ProfileImage extends StatelessWidget {
  Widget? img;
  ProfileImage({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.center,
        child: Material(
          child: InkWell(
            onTap: () {
              // call updateAvatar from bloc to upload img
             // context.read<ProfileBloc>().add(UpdateAvatar());
            },
            child:
                Container( child: img),
          ),
        ),
      ),
    );
  }
}