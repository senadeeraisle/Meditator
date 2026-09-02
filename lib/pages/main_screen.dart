import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditator/pages/main_screens/create_custom_exercise_page.dart';
import 'package:meditator/pages/main_screens/custom_exercise_page.dart';
import 'package:meditator/pages/main_screens/home_page.dart';
import 'package:meditator/pages/main_screens/mind_full_exercise_page.dart';
import 'package:meditator/pages/main_screens/profile_page.dart';
import 'package:meditator/utils/colors.dart';

class MainScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = [
    CreateCustomExercisePage(),
    HomePage(),
    MindFullExercisePage(),
    CustomExercisePage(),
    ProfilePage(),
  ];

  void onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BottomNavigationBar(
          onTap: onTappedItem,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.kPrimaryBlue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/house.svg",
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0
                      ? AppColors.kPrimaryBlue
                      : AppColors.kPrimaryLightBlue,
                  BlendMode.srcIn,
                ),
                semanticsLabel: "home svg",
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/brain.svg',
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1
                      ? AppColors.kPrimaryBlue
                      : AppColors.kPrimaryLightBlue,
                  BlendMode.srcIn,
                ),
                semanticsLabel: "brain svg",
              ),
              label: "Meditation",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/circle-plus.svg",
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2
                      ? AppColors.kPrimaryBlue
                      : AppColors.kPrimaryLightBlue,
                  BlendMode.srcIn,
                ),
                semanticsLabel: "circle-plus svg",
              ),
              label: "Create",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/file-plus.svg",
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 3
                      ? AppColors.kPrimaryBlue
                      : AppColors.kPrimaryLightBlue,
                  BlendMode.srcIn,
                ),
                semanticsLabel: "file-plus svg",
              ),
              label: "Custom",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/user-round-cog.svg",
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 4
                      ? AppColors.kPrimaryBlue
                      : AppColors.kPrimaryLightBlue,
                  BlendMode.srcIn,
                ),
                semanticsLabel: "user-round-cog svg",
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
