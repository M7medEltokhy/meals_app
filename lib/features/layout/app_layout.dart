import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meals_app/core/app_color.dart';
import 'package:meals_app/features/add_meal/add_meal_screen.dart';
import 'package:meals_app/features/home/home_screen.dart';
import 'package:meals_app/features/profile/profile_screen.dart';

class AppLayout extends StatefulWidget {
  AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  List<Widget> screens = [HomeScreen(), AddMealScreen(), ProfileScreen()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: AppColor.backgroundColor,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: AppColor.secondaryColor,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svgs/home.svg'),
            label: 'home'.tr(),
            activeIcon: SvgPicture.asset('assets/svgs/home_active.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svgs/add.svg'),
            label: 'add_meal'.tr(),
            activeIcon: SvgPicture.asset('assets/svgs/add_active.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svgs/profile.svg'),
            label: 'profile'.tr(),
            activeIcon: SvgPicture.asset('assets/svgs/profile_active.svg'),
          ),
        ],
      ),
    );
  }
}
