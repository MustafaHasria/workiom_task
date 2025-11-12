import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_colors.dart';

//? Reusable terms and privacy policy text widget
class TermsPrivacyText extends StatelessWidget {
  final String agreementText;
  final String termsText;
  final String andText;
  final String privacyText;
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  const TermsPrivacyText({
    super.key,
    required this.agreementText,
    required this.termsText,
    required this.andText,
    required this.privacyText,
    this.onTermsTap,
    this.onPrivacyTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleMedium?.copyWith(
      color: AppColors.grayText,
      fontSize: 13.sp,
    );
    
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: agreementText,
            style: textStyle,
          ),
          TextSpan(
            text: '$termsText\n',
            style: textStyle?.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: andText,
            style: textStyle,
          ),
          TextSpan(
            text: privacyText,
            style: textStyle?.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

