import 'package:flutter/material.dart';
import 'package:pharmaps/pages/home/home_screen.dart';
import 'package:pharmaps/pages/profile/profile_screen.dart';
import 'package:pharmaps/utils/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectIndex = 0;

  final pageList = [
    HomeScreen(),
    ProfileScreen(),
  ];

  onTappedItem(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    selectIndex = selectIndex.clamp(0, pageList.length - 1);

    return Scaffold(
      body: IndexedStack(
        index: selectIndex,
        children: pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Acceuil"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded), label: "Profile"),
        ],
        currentIndex: selectIndex,
        onTap: onTappedItem,
        unselectedItemColor: grey35Color,
      ),
    );
  }
}
