import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/app_color.dart';

class CustomAddMealText extends StatelessWidget {
  const CustomAddMealText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr(),
      style: TextStyle(color: AppColor.secondaryColor, fontSize: 16.sp),
    );
  }
}
