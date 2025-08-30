import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/app_color.dart';
import 'package:meals_app/core/app_constant.dart';
import 'package:meals_app/features/add_meal/widgets/customAddMealText.dart';
import 'package:meals_app/features/add_meal/widgets/customTextField.dart';
import 'package:meals_app/features/home/data/db_helper.dart';
import 'package:meals_app/features/home/data/meal_model.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        surfaceTintColor: AppColor.backgroundColor,
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
        title: Text(
          "Add Meal",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAddMealText(text: 'meal_name'),
                        CustomTextField(controller: mealNameController),
                        CustomAddMealText(text: 'image_url'),
                        CustomTextField(
                          maxLines: 3,
                          controller: imageUrlController,
                        ),
                        CustomAddMealText(text: 'calories'),
                        CustomTextField(
                          controller: caloriesController,
                          keyboardType: TextInputType.number,
                        ),
                        CustomAddMealText(text: 'rate'),
                        CustomTextField(
                          controller: rateController,
                          keyboardType: TextInputType.number,
                        ),
                        CustomAddMealText(text: 'time'),
                        CustomTextField(controller: timeController),
                        CustomAddMealText(text: 'description'),
                        CustomTextField(
                          maxLines: 5,
                          controller: descriptionController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                height: 50.h,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      MealModel meal = MealModel(
                        name: mealNameController.text,
                        imageUrl: imageUrlController.text,
                        calories: double.parse(caloriesController.text),
                        rate: double.parse(rateController.text),
                        time: timeController.text,
                        description: descriptionController.text,
                      );
                      dbHelper.insertMeal(meal).then((_) {
                        mealNameController.clear();
                        imageUrlController.clear();
                        caloriesController.clear();
                        rateController.clear();
                        timeController.clear();
                        descriptionController.clear();
                      });
                      Navigator.pushReplacementNamed(context, appLayout);
                    }
                  },
                  icon: Text(
                    'save'.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
