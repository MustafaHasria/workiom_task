import 'package:equatable/equatable.dart';
import 'package:workiom_task/core/status/bloc_status.dart';
import 'package:workiom_task/features/auth/data/model/auth_models.dart';

//? Auth state
class AuthState extends Equatable {
  final BlocStatus status;
  final LoginInfoModel? loginInfo;
  final EditionsModel? editions;
  final EditionModel? selectedEdition;
  final PasswordComplexityModel? passwordComplexity;
  final bool? isTenantAvailable;
  final String? tenantCheckName;
  final String? error;
  final bool isAuthenticated;
  //* Validation states
  final Map<String, bool>? passwordValidation;
  final double? passwordStrength;
  final bool? isEmailValid;
  final bool? isPasswordValid;
  final bool? isFormValid;

  const AuthState({
    this.status = const BlocStatus.initial(),
    this.loginInfo,
    this.editions,
    this.selectedEdition,
    this.passwordComplexity,
    this.isTenantAvailable,
    this.tenantCheckName,
    this.error,
    this.isAuthenticated = false,
    this.passwordValidation,
    this.passwordStrength,
    this.isEmailValid,
    this.isPasswordValid,
    this.isFormValid,
  });

  AuthState copyWith({
    BlocStatus? status,
    LoginInfoModel? loginInfo,
    EditionsModel? editions,
    EditionModel? selectedEdition,
    PasswordComplexityModel? passwordComplexity,
    bool? isTenantAvailable,
    String? tenantCheckName,
    String? error,
    bool? isAuthenticated,
    Map<String, bool>? passwordValidation,
    double? passwordStrength,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isFormValid,
  }) {
    return AuthState(
      status: status ?? this.status,
      loginInfo: loginInfo ?? this.loginInfo,
      editions: editions ?? this.editions,
      selectedEdition: selectedEdition ?? this.selectedEdition,
      passwordComplexity: passwordComplexity ?? this.passwordComplexity,
      isTenantAvailable: isTenantAvailable ?? this.isTenantAvailable,
      tenantCheckName: tenantCheckName ?? this.tenantCheckName,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      passwordValidation: passwordValidation ?? this.passwordValidation,
      passwordStrength: passwordStrength ?? this.passwordStrength,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [
        status,
        loginInfo,
        editions,
        selectedEdition,
        passwordComplexity,
        isTenantAvailable,
        tenantCheckName,
        error,
        isAuthenticated,
        passwordValidation,
        passwordStrength,
        isEmailValid,
        isPasswordValid,
        isFormValid,
      ];
}

