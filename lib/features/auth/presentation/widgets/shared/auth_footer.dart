import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/localization/app_text.dart';
import '../../../../../core/localization/locale_keys.g.dart';
import '../../../../../gen/assets.gen.dart';

//? Reusable footer widget for auth pages
class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            LocaleKeys.auth_stayOrganizedWith.tr(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.grayText,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              height: 1.60,
              letterSpacing: -0.24,
            ),
          ),
          SizedBox(width: 8.w),
          Assets.android.assets.iamges.icon.logo.svg(
            width: 100.75.w,
            height: 31.h,
          ),
        ],
      ),
    );
  }
}

