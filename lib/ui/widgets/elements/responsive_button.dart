// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:travel_app/ui/theme/colors.dart';
import 'app_large_text.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResposive;
  double? width;

  ResponsiveButton({super.key,
    this.isResposive=false,
    this.width=120,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: isResposive==true?double.maxFinite:width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.textColor1
        ),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Container(
                child: AppLargeText(text: "Записаться", color: Colors.white, size: 18,))
          ],
        ),
      ),
    );
  }
}
