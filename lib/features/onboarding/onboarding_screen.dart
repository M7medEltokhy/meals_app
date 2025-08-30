import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/app_color.dart';
import 'package:meals_app/core/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void changeLanguage() {
    if (context.locale == Locale('en')) {
      context.setLocale(Locale('ar'));
    } else {
      context.setLocale(Locale('en'));
    }
  }

  Future<void> finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ISFIRSTTIME, false);
    Navigator.pushReplacementNamed(context, appLayout);
  }

  List<String> titles = [
    "save_your_meals_ingredient",
    'use_our_app_the_best_choice',
    'our_app_your_ultimate_choice',
  ];

  List<String> subtitles = [
    'add_your_meals_and_its_ingredients_and_we_will_save_it_for_you',
    'the_best_choice_for_your_kitchen_do_not_hesitate',
    'all_the_best_restaurants_and_their_top_menus_are_ready_for_you',
  ];

  int pageIndex = 0;
  CarouselSliderController sliderController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pngs/background_image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              // alignment: Alignment.topLeft,
              // padding: EdgeInsets.only(top: 40, left: 20, right: 20),
              onPressed: changeLanguage,
              icon: Icon(Icons.language, size: 25.sp),
            ),
          ),
          Positioned(
            bottom: 30.h,
            right: 30.w,
            left: 30.w,
            child: Container(
              height: 400.h,
              width: 311.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(48.r),
              ),
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: sliderController,
                    options: CarouselOptions(
                      height: 300.h,
                      viewportFraction: 1,
                      disableCenter: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          pageIndex = index;
                        });
                      },
                    ),
                    items: List.generate(titles.length, (index) {
                      return Column(
                        children: [
                          SizedBox(height: 20.h),
                          Text(
                            titles[index].tr(),
                            style: TextStyle(
                              color: AppColor.backgroundColor,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            subtitles[index].tr(),
                            style: TextStyle(
                              color: AppColor.backgroundColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30.h),
                          DotsIndicator(
                            onTap: (index) {
                              debugPrint(index.toString());
                              sliderController.animateToPage(index);
                            },
                            dotsCount: titles.length,
                            position: pageIndex.toDouble(),
                            decorator: DotsDecorator(
                              spacing: EdgeInsets.symmetric(horizontal: 4.w),
                              size: Size(24.w, 6.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(
                                  100,
                                ),
                              ),
                              activeSize: Size(24.w, 6.h),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(
                                  20.r,
                                ),
                              ),
                              color: Colors.grey, // Inactive color
                              activeColor: AppColor.backgroundColor,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  pageIndex != 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: finishOnboarding,
                              child: Text(
                                'skip'.tr(),
                                style: TextStyle(
                                  color: AppColor.backgroundColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                sliderController.nextPage();
                              },
                              child: Text(
                                'next'.tr(),
                                style: TextStyle(
                                  color: AppColor.backgroundColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: finishOnboarding,
                          child: CircleAvatar(
                            backgroundColor: AppColor.backgroundColor,
                            radius: 30.r,
                            child: Icon(
                              Icons.arrow_forward,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
