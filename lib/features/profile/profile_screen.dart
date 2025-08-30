import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            CircleAvatar(
              radius: 70.r,
              backgroundImage: AssetImage('assets/pngs/my_profile.png'),
            ),
            SizedBox(height: 16.h),
            Text(
              'Mohamed Eltokhy',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6.h),
            Text(
              'Mobile App Developer',
              style: TextStyle(fontSize: 18.sp, color: Colors.grey[600]),
            ),
            SizedBox(height: 24.h),
            _buildInfoCard(icon: Icons.phone, text: '+20 1060052583'),
            _buildInfoCard(icon: Icons.email, text: 'mohamedali@gmail.com'),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () {
                if (context.locale.languageCode == 'en') {
                  context.setLocale(Locale('ar'));
                } else {
                  context.setLocale(Locale('en'));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
                elevation: 4,
              ),
              icon: Icon(Icons.language, size: 22),
              label: Text(
                context.locale.languageCode == 'en' ? "العربية" : "English",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String text}) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 30.sp, color: Colors.blueAccent),
        title: Text(text, style: TextStyle(fontSize: 18.sp)),
      ),
    );
  }
}
