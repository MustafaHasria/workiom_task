import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/localization/app_text.dart';

//? Reusable authentication header widget with title and subtitle
class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: AppColors.buttonTextDark,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        AppText(
          subtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.grayText,
            fontSize: 17.sp,
            fontWeight: FontWeight.w600
          ),
        ),
      ],
    );
  }
}

