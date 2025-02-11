
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/core/resource/color_manager.dart';

class CustomButton extends StatelessWidget{
  final String textBtn;
  final String imageBtn;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.imageBtn,
    required this.textBtn,
    required this.onPressed
});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.backGroundColor,
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Image.asset(imageBtn, width: 30, height: 30),
          SizedBox(width: 90),
          Text(
           textBtn,
            style: TextStyle(fontSize: 22.sp, color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

  }

}