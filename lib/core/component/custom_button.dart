import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String? iconPath;
  final bool isIconSvg;
  final double? width;
  final double? height;
  final double borderRadius;
  final Widget? trailingIcon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.iconPath,
    this.isIconSvg = true,
    this.width,
    this.height,
    this.borderRadius = 16,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? 343.w,
        height: height ?? 50.h,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              isIconSvg
                  ? SvgPicture.asset(
                      iconPath!,
                      width: 16.w,
                      height: 16.h,
                    )
                  : Image.asset(
                      iconPath!,
                      width: 16.w,
                      height: 16.h,
                    ),
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 15.sp,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                height: 1.40,
                letterSpacing: -0.32,
              ),
            ),
            if (trailingIcon != null) ...[
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: trailingIcon,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

