import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_task/core/constant/app_colors.dart';
import 'package:workiom_task/core/localization/locale_keys.g.dart';
import 'package:workiom_task/features/auth/presentation/widgets/shared/auth_footer.dart';
import 'package:workiom_task/gen/assets.gen.dart';

//? Thank you page after successful registration
class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              const Spacer(),

              //* Thank you message with logo inline
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: LocaleKeys.auth_thankYouMessage.tr(),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const TextSpan(text: ' '), //* Space before icon
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Assets.android.assets.iamges.icon.logoColor.svg(
                        width: 16.w,
                        height: 16.h,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 310.h),

              //* Footer
              const AuthFooter(),

              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
