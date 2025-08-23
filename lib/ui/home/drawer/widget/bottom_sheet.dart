
import 'package:flutter/material.dart';


import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';

class AppConfigBottomSheet extends StatelessWidget {
  String text;
  AppConfigBottomSheet({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.whiteColor, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: AppTextStyle.medium20White),
          Icon(
            Icons.arrow_drop_down_rounded,
            size: 35,
            color: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }
}
