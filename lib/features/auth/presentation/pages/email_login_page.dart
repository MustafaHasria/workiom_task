import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_task/core/validation/password_validator.dart';
import 'package:workiom_task/features/auth/data/di/auth_di.dart';
import 'package:workiom_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:workiom_task/features/auth/presentation/bloc/auth_event.dart';
import 'package:workiom_task/features/auth/presentation/bloc/auth_state.dart';
import 'package:workiom_task/features/auth/presentation/widgets/auth_header.dart';
import 'package:workiom_task/features/auth/presentation/widgets/custom_filled_button.dart';
import 'package:workiom_task/features/auth/presentation/widgets/email_login/custom_text_field.dart';
import 'package:workiom_task/features/auth/presentation/widgets/email_login/password_requirement.dart';
import 'package:workiom_task/features/auth/presentation/widgets/email_login/password_strength_indicator.dart';
import 'package:workiom_task/features/auth/presentation/widgets/shared/auth_footer.dart';
import 'package:workiom_task/core/constant/app_colors.dart';
import 'package:workiom_task/core/localization/locale_keys.g.dart';
import 'package:workiom_task/core/routing/app_routes.dart';
import 'package:workiom_task/core/shared/app_scaffold.dart';
import 'package:workiom_task/gen/assets.gen.dart';

//? Email login page with password creation
class EmailLoginPage extends StatelessWidget {
  const EmailLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: const _EmailLoginPageContent(),
    );
  }
}

class _EmailLoginPageContent extends StatefulWidget {
  const _EmailLoginPageContent();

  @override
  State<_EmailLoginPageContent> createState() => _EmailLoginPageContentState();
}

class _EmailLoginPageContentState extends State<_EmailLoginPageContent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _hasJustFetchedComplexity = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  //* Trigger validation in BLoC
  void _validateForm() {
    context.read<AuthBloc>().add(
          ValidateEmailPasswordEvent(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        //* Show error message
        if (state.status.isFail() && state.error != null) {
          //! Print error to terminal
          // ignore: avoid_print
          print('❌ Error: ${state.error}');
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
        
        //* After password complexity is loaded, validate the current password
        if (state.status.isSuccess() && 
            state.passwordComplexity != null && 
            _passwordController.text.isNotEmpty &&
            !_hasJustFetchedComplexity) {
          _hasJustFetchedComplexity = true;
          _validateForm();
        }
        
        //* Auto-navigate if password becomes valid after validation
        if (_hasJustFetchedComplexity &&
            state.isPasswordValid == true && 
            state.isEmailValid == true) {
          _hasJustFetchedComplexity = false;
          context.push(
            AppRoutes.companyEntry,
            extra: {
              'email': _emailController.text,
              'password': _passwordController.text,
            },
          );
        }
      },
      builder: (context, state) {
        final passwordComplexity = state.passwordComplexity;
        final isLoading = state.status.isLoading();
        final passwordValidation = state.passwordValidation;
        final passwordStrength = state.passwordStrength ?? 0.0;
        final isPasswordValid = state.isPasswordValid ?? false;
        final isEmailValid = state.isEmailValid ?? false;

        //* Check if form is valid
        final canProceed = isEmailValid && isPasswordValid && !isLoading;

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
                    //* Top bar with back button
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: SizedBox(
                        height: 42.h,
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios, size: 18.sp, color: AppColors.primary),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 19.h),

                    //* Header
                    AuthHeader(
                      title: LocaleKeys.auth_enterStrongPassword.tr(),
                      subtitle: LocaleKeys.auth_amazingJourney.tr(),
                    ),

                    SizedBox(height: 80.h),

                    //* Email field
                    CustomTextField(
                      controller: _emailController,
                      label: LocaleKeys.auth_yourWorkEmail.tr(),
                      hint: LocaleKeys.auth_hintEmail.tr(),
                      icon: Assets.android.assets.iamges.icon.email,
                      onChanged: (value) {
                        setState(() {});
                        _validateForm();
                      },
                    ),

                    SizedBox(height: 24.h),

                    //* Password field
                    CustomTextField(
                      controller: _passwordController,
                      label: LocaleKeys.auth_yourPassword.tr(),
                      hint: LocaleKeys.auth_hintPassword.tr(),
                      icon: Assets.android.assets.iamges.icon.lock,
                      obscureText: _obscurePassword,
                      isPassword: true,
                      onTogglePassword: _togglePasswordVisibility,
                      onChanged: (value) {
                        setState(() {});
                        _validateForm();
                      },
                    ),

                    //* Show password requirements only after fetching
                    if (passwordComplexity != null && _passwordController.text.isNotEmpty) ...[
                      SizedBox(height: 16.h),

                      //* Password strength
                      PasswordStrengthIndicator(
                        strengthText: PasswordValidator.getStrengthText(passwordStrength),
                        strengthColor: passwordStrength < 0.4
                            ? AppColors.passwordWeak
                            : passwordStrength < 1.0
                                ? AppColors.passwordMedium
                                : AppColors.passwordStrong,
                        strengthPercentage: passwordStrength,
                        isPasswordValid: isPasswordValid,
                      ),

                      SizedBox(height: 4.h),

                      //* Password requirements
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (passwordComplexity.requiredLength > 0)
                            PasswordRequirement(
                              text: LocaleKeys.auth_passwordMinLength.tr(namedArgs: {'length': '${passwordComplexity.requiredLength}'}),
                              isMet: passwordValidation?['length'] ?? false,
                            ),
                          if (passwordComplexity.requireUppercase)
                            PasswordRequirement(
                              text: LocaleKeys.auth_passwordUppercase.tr(),
                              isMet: passwordValidation?['uppercase'] ?? false,
                            ),
                          if (passwordComplexity.requireLowercase)
                            PasswordRequirement(
                              text: LocaleKeys.auth_passwordLowercase.tr(),
                              isMet: passwordValidation?['lowercase'] ?? false,
                            ),
                          if (passwordComplexity.requireDigit)
                            PasswordRequirement(
                              text: LocaleKeys.auth_passwordDigit.tr(),
                              isMet: passwordValidation?['digit'] ?? false,
                            ),
                          if (passwordComplexity.requireNonAlphanumeric)
                            PasswordRequirement(
                              text: LocaleKeys.auth_passwordSpecialChar.tr(),
                              isMet: passwordValidation?['special'] ?? false,
                            ),
                        ],
                      ),
                    ],

                    SizedBox(height: 30.h),

                    //* Confirm button
                    CustomFilledButton(
                      text: isLoading 
                          ? LocaleKeys.auth_validating.tr()
                          : (passwordComplexity != null && !canProceed)
                              ? LocaleKeys.auth_tryAgain.tr()
                              : LocaleKeys.auth_confirmPassword.tr(),
                      onPressed: isLoading
                          ? null
                          : () {
                              //* Always fetch password complexity to re-validate
                              if (passwordComplexity == null) {
                                //* First time - fetch complexity
                                context.read<AuthBloc>().add(const GetPasswordComplexityEvent());
                              } else if (canProceed) {
                                //* Password is valid - navigate
                                context.push(
                                  AppRoutes.companyEntry,
                                  extra: {
                                    'email': _emailController.text,
                                    'password': _passwordController.text,
                                  },
                                );
                              } else {
                                //* Password invalid - re-fetch and validate again
                                context.read<AuthBloc>().add(const GetPasswordComplexityEvent());
                              }
                            },
                      backgroundColor: !isLoading && 
                                      _emailController.text.isNotEmpty && 
                                      _passwordController.text.isNotEmpty
                          ? AppColors.primary 
                          : AppColors.buttonDisabled,
                      textColor: AppColors.textOnPrimary,
                    ),

                    SizedBox(height: 136.h),

                    //* Footer
                    const AuthFooter(),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
