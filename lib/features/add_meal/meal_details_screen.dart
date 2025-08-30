import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meals_app/core/app_color.dart';
import 'package:meals_app/features/home/data/meal_model.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.mealModel});
  final MealModel mealModel;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        surfaceTintColor: AppColor.backgroundColor,

        title: Text(mealModel.name),
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220.h,
              width: size.width,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: mealModel.imageUrl,
                placeholder: (context, url) => Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/pngs/errorImage.png',
                  height: 100.h,
                  width: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        mealModel.name,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${mealModel.calories} kcal",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SvgPicture.asset('assets/svgs/time.svg'),
                      SizedBox(width: 5.w),
                      Text(
                        mealModel.time,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff878787),
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset('assets/svgs/rate.svg'),
                      SizedBox(width: 5.w),
                      Text(
                        mealModel.rate.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff878787),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.h),
                    child: Text(
                      mealModel.description,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
