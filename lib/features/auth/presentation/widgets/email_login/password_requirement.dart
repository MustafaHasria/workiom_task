import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/localization/app_text.dart';
import '../../../../../gen/assets.gen.dart';

//? Password requirement item widget
class PasswordRequirement extends StatelessWidget {
  final String text;
  final bool isMet;
  final bool? isLoading;

  const PasswordRequirement({
    super.key,
    required this.text,
    required this.isMet,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //? Show loading indicator or icon
        SizedBox(
          width: 16.w,
          height: 16.h,
          child: isLoading == true
              ? CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                )
              : _buildIcon(),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: AppText(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.grayText,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    //? Show check icon when met, wrong icon when not met
    final icon = isMet 
        ? Assets.android.assets.iamges.icon.check
        : Assets.android.assets.iamges.icon.wrong;
    
    return icon.svg(width: 16.w, height: 16.h);
  }
}

