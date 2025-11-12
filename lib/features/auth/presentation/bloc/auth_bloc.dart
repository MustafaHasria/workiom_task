import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workiom_task/core/status/bloc_status.dart';
import 'package:workiom_task/core/validation/email_validator.dart';
import 'package:workiom_task/core/validation/name_validator.dart';
import 'package:workiom_task/core/validation/password_validator.dart';
import 'package:workiom_task/core/validation/tenant_name_validator.dart';
import 'package:workiom_task/features/auth/domain/repository/auth_repository.dart';
import 'package:workiom_task/features/auth/presentation/bloc/auth_event.dart';
import 'package:workiom_task/features/auth/presentation/bloc/auth_state.dart';

//? Auth BLoC for handling authentication logic
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(const AuthState()) {
    on<CheckLoginStatusEvent>(_onCheckLoginStatus);
    on<GetEditionsEvent>(_onGetEditions);
    on<GetPasswordComplexityEvent>(_onGetPasswordComplexity);
    on<CheckTenantAvailabilityEvent>(
      _onCheckTenantAvailability,
      transformer: restartable(),
    );
    on<RegisterTenantEvent>(_onRegisterTenant);
    on<AuthenticateEvent>(_onAuthenticate);
    on<ValidateEmailPasswordEvent>(_onValidateEmailPassword);
    on<ValidateRegistrationFormEvent>(_onValidateRegistrationForm);
  }

  //* Check login status
  Future<void> _onCheckLoginStatus(
    CheckLoginStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: const BlocStatus.loading()));

    final result = await _repository.getCurrentLoginInfo();

    result.fold(
      (error) => emit(state.copyWith(
        status: BlocStatus.fail(error: error),
        error: error,
      )),
      (loginInfo) => emit(state.copyWith(
        status: const BlocStatus.success(),
        loginInfo: loginInfo,
        isAuthenticated: loginInfo.isLoggedIn,
      )),
    );
  }

  //* Get editions
  Future<void> _onGetEditions(
    GetEditionsEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: const BlocStatus.loading()));

    final result = await _repository.getEditions();

    result.fold(
      (error) => emit(state.copyWith(
        status: BlocStatus.fail(error: error),
        error: error,
      )),
      (editions) {
        //* Select first registrable edition by default
        final editionsList = editions.editionsWithFeatures;
        final defaultEdition = editionsList.firstWhere(
          (e) => e.isRegistrable,
          orElse: () => editionsList.first,
        );

        emit(state.copyWith(
          status: const BlocStatus.success(),
          editions: editions,
          selectedEdition: defaultEdition,
        ));
      },
    );
  }

  //* Get password complexity
  Future<void> _onGetPasswordComplexity(
    GetPasswordComplexityEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: const BlocStatus.loading()));

    final result = await _repository.getPasswordComplexity();

    result.fold(
      (error) => emit(state.copyWith(
        status: BlocStatus.fail(error: error),
        error: error,
      )),
      (complexity) => emit(state.copyWith(
        status: const BlocStatus.success(),
        passwordComplexity: complexity,
      )),
    );
  }

  //* Check tenant availability
  Future<void> _onCheckTenantAvailability(
    CheckTenantAvailabilityEvent event,
    Emitter<AuthState> emit,
  ) async {
    //* Don't show loading for tenant check (it's a background operation)
    final result = await _repository.isTenantAvailable(event.tenancyName);

    result.fold(
      (error) => emit(state.copyWith(
        isTenantAvailable: false,
        tenantCheckName: event.tenancyName,
        error: error,
      )),
      (isAvailable) => emit(state.copyWith(
        isTenantAvailable: isAvailable,
        tenantCheckName: event.tenancyName,
      )),
    );
  }

  //* Register tenant
  Future<void> _onRegisterTenant(
    RegisterTenantEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: const BlocStatus.loading()));

    final result = await _repository.registerTenant(
      adminEmailAddress: event.adminEmailAddress,
      adminFirstName: event.adminFirstName,
      adminLastName: event.adminLastName,
      adminPassword: event.adminPassword,
      editionId: event.editionId,
      name: event.name,
      tenancyName: event.tenancyName,
      timeZone: event.timeZone,
    );

    result.fold(
      (error) => emit(state.copyWith(
        status: BlocStatus.fail(error: error),
        error: error,
      )),
      (_) => emit(state.copyWith(
        status: const BlocStatus.success(),
      )),
    );
  }

  //* Authenticate user
  Future<void> _onAuthenticate(
    AuthenticateEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: const BlocStatus.loading()));

    final result = await _repository.authenticate(
      userNameOrEmailAddress: event.userNameOrEmailAddress,
      password: event.password,
      tenantName: event.tenantName,
      ianaTimeZone: event.ianaTimeZone,
    );

    result.fold(
      (error) => emit(state.copyWith(
        status: BlocStatus.fail(error: error),
        error: error,
      )),
      (token) => emit(state.copyWith(
        status: const BlocStatus.success(),
        isAuthenticated: true,
      )),
    );
  }

  //* Validate email and password
  void _onValidateEmailPassword(
    ValidateEmailPasswordEvent event,
    Emitter<AuthState> emit,
  ) {
    //* Validate email
    final isEmailValid = EmailValidator.isValid(event.email);

    //* Validate password if complexity is loaded
    Map<String, bool>? passwordValidation;
    double? passwordStrength;
    bool? isPasswordValid;

    if (state.passwordComplexity != null && event.password.isNotEmpty) {
      passwordValidation = PasswordValidator.validatePassword(
        event.password,
        state.passwordComplexity!,
      );
      passwordStrength = PasswordValidator.calculateStrength(
        event.password,
        state.passwordComplexity!,
      );
      isPasswordValid = PasswordValidator.isPasswordValid(
        event.password,
        state.passwordComplexity!,
      );
    }

    emit(state.copyWith(
      isEmailValid: isEmailValid,
      passwordValidation: passwordValidation,
      passwordStrength: passwordStrength,
      isPasswordValid: isPasswordValid,
    ));
  }

  //* Validate registration form
  void _onValidateRegistrationForm(
    ValidateRegistrationFormEvent event,
    Emitter<AuthState> emit,
  ) {
    //* Validate all fields
    final isTenantNameValid = TenantNameValidator.isValid(event.tenancyName);
    final isFirstNameValid = NameValidator.isValid(event.firstName);
    final isLastNameValid = NameValidator.isValid(event.lastName);
    
    //* Check if tenant is available
    final isTenantChecked = state.tenantCheckName == event.tenancyName;
    final isTenantAvailable = state.isTenantAvailable == true;
    
    //* Overall form validity
    final isFormValid = isTenantNameValid && 
                        isTenantChecked && 
                        isTenantAvailable && 
                        isFirstNameValid && 
                        isLastNameValid &&
                        state.selectedEdition != null;

    emit(state.copyWith(
      isFormValid: isFormValid,
    ));
  }
}

