import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/localization/app_text.dart';
import '../../../../../gen/assets.gen.dart';

//? Reusable custom text field for email/password input
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? trailingText;
  final SvgGenImage? icon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool isPassword;
  final VoidCallback? onTogglePassword;
  final bool showTrailingIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.trailingText,
    this.icon,
    this.obscureText = false,
    this.onChanged,
    this.onClear,
    this.isPassword = false,
    this.onTogglePassword,
    this.showTrailingIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Label
        AppText(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        
        SizedBox(height: 12.h),
        
        //* Input field
        Container(
          width: 343.w,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //* Icon, value, and cancel row
              Row(
                children: [
                  //* Leading icon
                  if (icon != null) ...[
                    icon!.svg(width: 16.w, height: 16.h),
                    SizedBox(width: 8.w),
                  ],
                  
                  //* Text field
                  Expanded(
                    child: TextField(
                      controller: controller,
                      obscureText: obscureText,
                      onChanged: onChanged,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.60,
                      ),
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.grayText,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.60,
                          letterSpacing: -0.24,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  
                  //* Trailing text (if provided)
                  if (trailingText != null) ...[
                    AppText(
                      trailingText!,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF737373),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.60,
                        letterSpacing: -0.24,
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  
                  //* Trailing icon (eye/eyeSlash for password, cancel for others)
                  if (showTrailingIcon)
                    GestureDetector(
                      onTap: isPassword ? onTogglePassword : (onClear ?? () => controller.clear()),
                      child: isPassword
                          ? (obscureText
                              ? Assets.android.assets.iamges.icon.eyeSlash.svg(
                                  width: 20.w,
                                  height: 20.h,
                                )
                              : Assets.android.assets.iamges.icon.eye.svg(
                                  width: 28.w,
                                  height: 28.h,
                                ))
                          : Assets.android.assets.iamges.icon.cancle.svg(
                              width: 24.w,
                              height: 24.h,
                            ),
                    ),
                ],
              ),
              
              SizedBox(height: 8.h),
              
              //* Divider
              Container(
                width: 319.w,
                height: 1.h,
                decoration: ShapeDecoration(
                  color: AppColors.dividerGray,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
