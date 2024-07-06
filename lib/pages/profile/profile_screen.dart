import 'package:flutter/material.dart';
import 'package:pharmaps/models/profile.dart';
import 'package:pharmaps/pages/login/login_screen.dart';
import 'package:pharmaps/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
   String? fullName, email;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      fullName = sharedPreferences.getString(Profile.fullname);
      email = sharedPreferences.getString(Profile.email);
    });
  }

   signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(Profile.userId);
    sharedPreferences.remove(Profile.fullname);
    sharedPreferences.remove(Profile.email);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>const LoginScreen()),
        (route) => false);
  }
  
  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding:const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Profile",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                InkWell(
                  onTap: () {
                    signOut();
                  },
                  child:const Icon(
                    Icons.exit_to_app,
                    color: greenColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding:const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName!,
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
         const SizedBox(
            height: 20,
          ),
          Container(
            padding:const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: lightTextStyle,
                ),
               const SizedBox(
                  height: 8,
                ),
                Text(
                  email!,
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}