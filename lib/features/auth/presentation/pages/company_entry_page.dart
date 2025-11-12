import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workiom_task/core/validation/tenant_name_validator.dart';
import 'package:workiom_task/features/auth/data/di/auth_di.dart';
import 'package:workiom_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:workiom_task/features/auth/presentation/bloc/auth_event.dart';
import 'package:workiom_task/features/auth/presentation/bloc/auth_state.dart';
import 'package:workiom_task/features/auth/presentation/widgets/auth_header.dart';
import 'package:workiom_task/features/auth/presentation/widgets/custom_filled_button.dart';
import 'package:workiom_task/features/auth/presentation/widgets/email_login/custom_text_field.dart';
import 'package:workiom_task/features/auth/presentation/widgets/shared/auth_footer.dart';
import 'package:workiom_task/core/constant/app_colors.dart';
import 'package:workiom_task/core/localization/locale_keys.g.dart';
import 'package:workiom_task/core/routing/app_routes.dart';
import 'package:workiom_task/core/shared/app_scaffold.dart';
import 'package:workiom_task/gen/assets.gen.dart';

//? Company entry page for workspace creation
class CompanyEntryPage extends StatelessWidget {
  final String email;
  final String password;

  const CompanyEntryPage({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(const GetEditionsEvent()),
      child: _CompanyEntryPageContent(email: email, password: password),
    );
  }
}

class _CompanyEntryPageContent extends StatefulWidget {
  final String email;
  final String password;

  const _CompanyEntryPageContent({
    required this.email,
    required this.password,
  });

  @override
  State<_CompanyEntryPageContent> createState() => _CompanyEntryPageContentState();
}

class _CompanyEntryPageContentState extends State<_CompanyEntryPageContent> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _hasRegistered = false;
  bool _hasAttemptedAuth = false;

  @override
  void dispose() {
    _companyNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  //* Trigger tenant availability check in BLoC
  void _checkTenantAvailability(String tenancyName) {
    if (tenancyName.isEmpty || !TenantNameValidator.isValid(tenancyName)) {
      return;
    }
    context.read<AuthBloc>().add(CheckTenantAvailabilityEvent(tenancyName));
  }

  //* Trigger form validation in BLoC
  void _validateForm() {
    context.read<AuthBloc>().add(
          ValidateRegistrationFormEvent(
            tenancyName: _companyNameController.text.trim(),
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
          ),
        );
  }

  //* Handle registration
  void _handleRegister(BuildContext context, AuthState state) {
    final tenancyName = _companyNameController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    if (state.selectedEdition == null) {
      _showError(context, LocaleKeys.auth_noEditionSelected.tr());
      return;
    }

    //* Get timezone (using a default for now)
    final timeZone = 'UTC';

    //* Mark that we're starting registration
    setState(() {
      _hasRegistered = true;
      _hasAttemptedAuth = false;
    });

    //! Print registration attempt
    // ignore: avoid_print
    print('📝 Registering tenant:');
    // ignore: avoid_print
    print('   Email: ${widget.email}');
    // ignore: avoid_print
    print('   Tenant: $tenancyName');
    // ignore: avoid_print
    print('   Name: $firstName $lastName');

    //* Register tenant
    context.read<AuthBloc>().add(
          RegisterTenantEvent(
            adminEmailAddress: widget.email,
            adminFirstName: firstName,
            adminLastName: lastName,
            adminPassword: widget.password,
            editionId: state.selectedEdition!.id,
            name: tenancyName,
            tenancyName: tenancyName,
            timeZone: timeZone,
          ),
        );
  }

  void _showError(BuildContext context, String message) {
    //! Print error to terminal
    print('❌ Error: $message');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        //* Show error message
        if (state.status.isFail() && state.error != null) {
          _showError(context, state.error!);
        }

        //* Handle successful registration - only trigger auth once
        if (state.status.isSuccess() && !state.isAuthenticated && _hasRegistered && !_hasAttemptedAuth) {
          _hasAttemptedAuth = true;
          //* After registration, authenticate the user
          final tenancyName = _companyNameController.text.trim();

          //! Print authentication attempt
          // ignore: avoid_print
          print('🔐 Attempting to authenticate with:');
          // ignore: avoid_print
          print('   Email: ${widget.email}');
          // ignore: avoid_print
          print('   Tenant: $tenancyName');

          context.read<AuthBloc>().add(
                AuthenticateEvent(
                  userNameOrEmailAddress: widget.email,
                  password: widget.password,
                  tenantName: tenancyName,
                  ianaTimeZone: 'UTC',
                ),
              );
        }

        //* Handle successful authentication
        if (state.isAuthenticated) {
          FocusScope.of(context).unfocus();
          _showSuccess(context, LocaleKeys.auth_registrationSuccessful.tr());
          //* Navigate to thank you page
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              context.go(AppRoutes.thankYou);
            }
          });
        }
      },
      builder: (context, state) {
        final isLoading = state.status.isLoading();
        final tenancyName = _companyNameController.text.trim();
        final isTenantChecked = state.tenantCheckName == tenancyName;
        final isTenantAvailable = state.isTenantAvailable;
        final isFormValid = state.isFormValid ?? false;

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
                      title: LocaleKeys.auth_enterCompanyName.tr(),
                      subtitle: LocaleKeys.auth_amazingJourney.tr(),
                    ),

                    SizedBox(height: 92.h),

                    //* Company name field with domain suffix
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: _companyNameController,
                          label: LocaleKeys.auth_yourCompanyTeamName.tr(),
                          hint: LocaleKeys.auth_hintWorkspaceName.tr(),
                          trailingText: '.workiom.com',
                          icon: Assets.android.assets.iamges.icon.pepole,
                          showTrailingIcon: false,
                          onChanged: (value) {
                            setState(() {});
                            _checkTenantAvailability(value);
                            _validateForm();
                          },
                        ),
                        //* Availability status
                        if (tenancyName.isNotEmpty && TenantNameValidator.isValid(tenancyName))
                          Padding(
                            padding: EdgeInsets.only(left: 24.w, top: 4.h),
                            child: Text(
                              isTenantChecked
                                  ? (isTenantAvailable == true
                                      ? LocaleKeys.auth_available.tr()
                                      : LocaleKeys.auth_notAvailable.tr())
                                  : LocaleKeys.auth_checking.tr(),
                              style: TextStyle(
                                color: isTenantChecked
                                    ? (isTenantAvailable == true ? Colors.green : Colors.red)
                                    : AppColors.grayText,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    //* First name field
                    CustomTextField(
                      controller: _firstNameController,
                      label: LocaleKeys.auth_yourFirstName.tr(),
                      hint: LocaleKeys.auth_hintFirstName.tr(),
                      icon: Assets.android.assets.iamges.icon.text,
                      showTrailingIcon: false,
                      onChanged: (value) {
                        setState(() {});
                        _validateForm();
                      },
                    ),

                    SizedBox(height: 24.h),

                    //* Last name field
                    CustomTextField(
                      controller: _lastNameController,
                      label: LocaleKeys.auth_yourLastName.tr(),
                      hint: LocaleKeys.auth_hintLastName.tr(),
                      icon: Assets.android.assets.iamges.icon.text,
                      showTrailingIcon: false,
                      onChanged: (value) {
                        setState(() {});
                        _validateForm();
                      },
                    ),

                    SizedBox(height: 30.h),

                    //* Create workspace button
                    CustomFilledButton(
                      text: isLoading 
                          ? LocaleKeys.auth_creating.tr()
                          : LocaleKeys.auth_createWorkspace.tr(),
                      onPressed: (isFormValid && !isLoading)
                          ? () => _handleRegister(context, state)
                          : null,
                      backgroundColor: (isFormValid && !isLoading) 
                          ? AppColors.primary 
                          : AppColors.buttonDisabled,
                      textColor: AppColors.textOnPrimary,
                    ),

                    SizedBox(height: 136.h),

                    //* Footer
                    const AuthFooter(),

                    SizedBox(height: 50.h),
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
