import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/localization/app_text.dart';
import '../../../../../gen/assets.gen.dart';

//? Password strength indicator widget
class PasswordStrengthIndicator extends StatelessWidget {
  final String strengthText;
  final Color strengthColor;
  final double strengthPercentage;
  final bool isPasswordValid;

  const PasswordStrengthIndicator({
    super.key,
    required this.strengthText,
    required this.strengthColor,
    required this.strengthPercentage,
    this.isPasswordValid = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Progress bars
        Stack(
          children: [
            //* Background bar
            Container(
              width: 343.w,
              height: 7.h,
              decoration: ShapeDecoration(
                color: AppColors.buttonGrayBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),

            //* Strength bar
            Container(
              width: (343.w * strengthPercentage),
              height: 7.h,
              decoration: ShapeDecoration(
                color: strengthColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),
        //* Strength text with icon
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //* Show check icon when password is valid, warning icon otherwise
            (isPasswordValid 
                ? Assets.android.assets.iamges.icon.check 
                : Assets.android.assets.iamges.icon.warning)
                .svg(
              width: 16.w,
              height: 16.h,
            ),
            SizedBox(width: 8.w),
            AppText(
              strengthText,
              style: theme.textTheme.labelLarge?.copyWith(
                color: AppColors.darkGrayText,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
