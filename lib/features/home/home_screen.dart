import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:meals_app/core/app_color.dart';
import 'package:meals_app/features/add_meal/meal_details_screen.dart';
import 'package:meals_app/features/home/data/db_helper.dart';
import 'package:meals_app/features/home/data/meal_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    'assets/pngs/one.png',
    'assets/pngs/two.png',
    'assets/pngs/three.png',
  ];

  int pageIndex = 0;

  // CarouselSliderController sliderController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   centerTitle: true,
        //   title: Text(
        //     "my_meals".tr(),
        //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        //   ),
        // ),
        body: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                // carouselController: sliderController,
                options: CarouselOptions(
                  height: 220.h,
                  viewportFraction: 1,
                  disableCenter: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                ),
                items: List.generate(images.length, (index) {
                  return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10.r),
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                            width: size.width,
                            height: size.height * 0.3,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.h,
                        left: 0,
                        right: 0,
                        child: DotsIndicator(
                          // onTap: (index) {
                          //   debugPrint(index.toString());
                          //   sliderController.animateToPage(index);
                          // },
                          dotsCount: images.length,
                          position: pageIndex.toDouble(),
                          decorator: DotsDecorator(
                            spacing: EdgeInsets.symmetric(horizontal: 4.w),
                            size: Size(24.w, 6.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(20.r),
                            ),
                            activeSize: Size(24.w, 6.h),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(20.r),
                            ),
                            color: Colors.grey, // Inactive color
                            activeColor: AppColor.backgroundColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, //   <<=====
                  children: [
                    Text(
                      'my_meals'.tr(),
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: DatabaseHelper().getMeals(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          width: 100.w,
                          height: 100.h,
                          child: Lottie.asset(
                            'assets/animations/loading.json',
                            width: 100.w,
                            height: 100.h,
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return SizedBox(
                          width: size.width,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'no_meals'.tr(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text('add_now'.tr(), style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 16.w),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          MealModel meal = snapshot.data![index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MealDetailsScreen(mealModel: meal),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: SizedBox(
                                  height: 70.h,
                                  width: 70.w,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: meal.imageUrl,
                                    placeholder: (context, url) => Container(
                                      width: 100.w,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          'assets/pngs/errorImage.png',
                                          height: 100.h,
                                          width: 100.h,
                                          fit: BoxFit.cover,
                                        ),
                                  ),
                                ),
                              ),
                              title: Text(
                                meal.name,
                                style: TextStyle(
                                  color: AppColor.secondaryColor,
                                  fontSize: 16.sp,
                                ),
                              ),
                              subtitle: Text(
                                '${meal.calories.toString()} calories',
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//Row(
//   children: [
//     Image.asset(
//       'assets/pngs/Breakfast Smoothie.png',
//       height: 56.h,
//     ),
//     SizedBox(width: 10.w),
//     Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'breakfast_smoothie'.tr(),
//           style: TextStyle(
//             fontSize: 16.sp,
//             color: AppColor.secondaryColor,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         SizedBox(height: 2.h),
//         Text(
//           '350_calories'.tr(),
//           style: TextStyle(
//             fontSize: 14.sp,
//             color: AppColor.primaryColor,
//           ),
//         ),
//       ],
//     ),
//   ],
// ),