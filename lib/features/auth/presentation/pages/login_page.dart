import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_task/features/auth/presentation/widgets/auth_header.dart';
import 'package:workiom_task/features/auth/presentation/widgets/custom_button.dart';
import 'package:workiom_task/features/auth/presentation/widgets/custom_filled_button.dart';
import 'package:workiom_task/features/auth/presentation/widgets/divider_text.dart';
import 'package:workiom_task/features/auth/presentation/widgets/shared/auth_footer.dart';
import 'package:workiom_task/features/auth/presentation/widgets/terms_privacy_text.dart';
import 'package:workiom_task/core/constant/app_colors.dart';
import 'package:workiom_task/core/localization/app_text.dart';
import 'package:workiom_task/core/localization/locale_keys.g.dart';
import 'package:workiom_task/core/routing/app_routes.dart';
import 'package:workiom_task/core/shared/app_scaffold.dart';
import 'package:workiom_task/gen/assets.gen.dart';

//? Login page with Google and Email authentication options
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold.clean(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              //* Top bar with Sign In link
              SizedBox(
                height: 42.h,
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 18.sp, color: AppColors.primary),
                    SizedBox(width: 5.w),
                    AppText(
                      LocaleKeys.auth_signIn.tr(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primary,
                        fontSize: 17.sp,
                
                      ),
                    ),
                ],
              ),
            ),

              SizedBox(height: 19.h),
              
              //* Header
              AuthHeader(
                title: LocaleKeys.auth_createAccount.tr(),
                subtitle: LocaleKeys.auth_amazingJourney.tr(),
              ),
              
              SizedBox(height: 137.h),
              
              //* Google button
              CustomButton(
          text: LocaleKeys.auth_continueWithGoogle.tr(),
                onPressed: () {},
                backgroundColor: AppColors.buttonGrayBackground,
                textColor: AppColors.buttonTextDark,
                icon: Assets.android.assets.iamges.icon.googel,
        ),
        
        SizedBox(height: 30.h),
        
              //* Divider
              Center(child: DividerText(text: LocaleKeys.auth_or.tr())),
        
        SizedBox(height: 30.h),
        
              //* Email button
              CustomFilledButton(
          text: LocaleKeys.auth_continueWithEmail.tr(),
                onPressed: () => context.push(AppRoutes.emailLogin),
          backgroundColor: AppColors.primary,
                textColor: AppColors.textOnPrimary,
        ),
        
        SizedBox(height: 16.h),
        
              //* Terms and privacy
              Center(
          child: TermsPrivacyText(
                  agreementText: LocaleKeys.auth_termsAgreement.tr(),
                  termsText: LocaleKeys.auth_termsOfService.tr(),
                  andText: LocaleKeys.auth_and.tr(),
                  privacyText: LocaleKeys.auth_privacyPolicy.tr(),
          ),
        ),
              
              SizedBox(height: 161.h),
              
              //* Footer
              Center(
                child: Column(
      children: [
                    //* Language
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
                        Icon(Icons.language, size: 16.sp, color: AppColors.grayText),
            SizedBox(width: 8.w),
                        AppText(
                          LocaleKeys.auth_english.tr(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.grayText,
                            fontSize: 12.sp,
            ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.arrow_drop_down_outlined, size: 16.sp, color: AppColors.grayText),
                      ],
            ),
                    
                    SizedBox(height: 16.h),
                    
                    //* Branding
                    const AuthFooter(),
                  ],
                ),
              ),
              
              SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
