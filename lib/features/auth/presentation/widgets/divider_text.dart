import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/localization/app_text.dart';

//? Reusable divider with text in the middle (e.g., "Or")
class DividerText extends StatelessWidget {
  final String text;

  const DividerText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Opacity(
      opacity: 0.70,
      child: AppText(
        text,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodySmall?.copyWith(
          color: AppColors.grayText,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          height: 1.33,
        ),
      ),
    );
  }
}

