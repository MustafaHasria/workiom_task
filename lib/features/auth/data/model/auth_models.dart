import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

//? ============= DOMAIN MODELS (Plain Classes) =============

//* User model
class UserModel {
  final int? id;
  final String? name;
  final String? surname;
  final String? userName;
  final String? emailAddress;

  UserModel({
    this.id,
    this.name,
    this.surname,
    this.userName,
    this.emailAddress,
  });
}

//* Tenant model
class TenantModel {
  final int? id;
  final String? tenancyName;
  final String? name;

  TenantModel({
    this.id,
    this.tenancyName,
    this.name,
  });
}

//* Login info model
class LoginInfoModel {
  final UserModel? user;
  final TenantModel? tenant;

  LoginInfoModel({
    this.user,
    this.tenant,
  });

  //* Check if user is logged in
  bool get isLoggedIn => user != null;

  //* Check if tenant is selected
  bool get hasTenant => tenant != null;
}

//* Edition model
class EditionModel {
  final int id;
  final String displayName;
  final bool isRegistrable;
  final double? annualPrice;
  final double? monthlyPrice;
  final bool hasTrial;
  final bool isMostPopular;

  EditionModel({
    required this.id,
    required this.displayName,
    required this.isRegistrable,
    this.annualPrice,
    this.monthlyPrice,
    required this.hasTrial,
    required this.isMostPopular,
  });
}

//* Editions model (wrapper for list of editions)
class EditionsModel {
  final List<EditionModel> editionsWithFeatures;

  EditionsModel({
    required this.editionsWithFeatures,
  });
}

//* Password complexity model
class PasswordComplexityModel {
  final bool requireDigit;
  final bool requireLowercase;
  final bool requireNonAlphanumeric;
  final bool requireUppercase;
  final int requiredLength;

  PasswordComplexityModel({
    required this.requireDigit,
    required this.requireLowercase,
    required this.requireNonAlphanumeric,
    required this.requireUppercase,
    required this.requiredLength,
  });
}

//? ============= REQUEST DTOs (Freezed) =============

//* Register tenant request
@freezed
abstract class RegisterTenantRequestDto with _$RegisterTenantRequestDto {
  const factory RegisterTenantRequestDto({
    required String adminEmailAddress,
    required String adminFirstName,
    required String adminLastName,
    required String adminPassword,
    String? captchaResponse,
    required int editionId,
    required String name,
    required String tenancyName,
  }) = _RegisterTenantRequestDto;

  factory RegisterTenantRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterTenantRequestDtoFromJson(json);
}

//* Authenticate request
@freezed
abstract class AuthenticateRequestDto with _$AuthenticateRequestDto {
  const factory AuthenticateRequestDto({
    required String ianaTimeZone,
    required String password,
    @Default(false) bool rememberClient,
    String? returnUrl,
    @Default(false) bool singleSignIn,
    required String tenantName,
    required String userNameOrEmailAddress,
  }) = _AuthenticateRequestDto;

  factory AuthenticateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateRequestDtoFromJson(json);
}

//* Tenant available request
@freezed
abstract class TenantAvailableRequestDto with _$TenantAvailableRequestDto {
  const factory TenantAvailableRequestDto({
    required String tenancyName,
  }) = _TenantAvailableRequestDto;

  factory TenantAvailableRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TenantAvailableRequestDtoFromJson(json);
}

//? ============= RESPONSE DTOs (Freezed) =============

//* Login info response
@freezed
abstract class LoginInfoResponseDto with _$LoginInfoResponseDto {
  const factory LoginInfoResponseDto({
    UserResponseDto? user,
    TenantResponseDto? tenant,
  }) = _LoginInfoResponseDto;

  factory LoginInfoResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoResponseDtoFromJson(json);
}

@freezed
abstract class UserResponseDto with _$UserResponseDto {
  const factory UserResponseDto({
    int? id,
    String? name,
    String? surname,
    String? userName,
    String? emailAddress,
  }) = _UserResponseDto;

  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDtoFromJson(json);
}

@freezed
abstract class TenantResponseDto with _$TenantResponseDto {
  const factory TenantResponseDto({
    int? id,
    String? tenancyName,
    String? name,
  }) = _TenantResponseDto;

  factory TenantResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TenantResponseDtoFromJson(json);
}

//* Edition response
@freezed
abstract class EditionResponseDto with _$EditionResponseDto {
  const factory EditionResponseDto({
    int? id,
    String? name,
    String? displayName,
    String? publicDescription,
    @Default(false) bool isRegistrable,
    num? annualPrice,
    num? monthlyPrice,
    @Default(false) bool hasTrial,
    bool? isMostPopular,
    int? type,
    int? minimumUsersCount,
    int? trialDayCount,
  }) = _EditionResponseDto;

  factory EditionResponseDto.fromJson(Map<String, dynamic> json) =>
      _$EditionResponseDtoFromJson(json);
}

@freezed
abstract class EditionWithFeaturesDto with _$EditionWithFeaturesDto {
  const factory EditionWithFeaturesDto({
    EditionResponseDto? edition,
    List<Map<String, dynamic>>? featureValues,
  }) = _EditionWithFeaturesDto;

  factory EditionWithFeaturesDto.fromJson(Map<String, dynamic> json) =>
      _$EditionWithFeaturesDtoFromJson(json);
}

@freezed
abstract class EditionsResponseDto with _$EditionsResponseDto {
  const factory EditionsResponseDto({
    List<EditionWithFeaturesDto>? editionsWithFeatures,
  }) = _EditionsResponseDto;

  factory EditionsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$EditionsResponseDtoFromJson(json);
}

//* Password complexity response
@freezed
abstract class PasswordComplexityResponseDto with _$PasswordComplexityResponseDto {
  const factory PasswordComplexityResponseDto({
    required bool requireDigit,
    required bool requireLowercase,
    required bool requireNonAlphanumeric,
    required bool requireUppercase,
    required int requiredLength,
  }) = _PasswordComplexityResponseDto;

  factory PasswordComplexityResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PasswordComplexityResponseDtoFromJson(json);
}

@freezed
abstract class PasswordComplexityWrapperDto with _$PasswordComplexityWrapperDto {
  const factory PasswordComplexityWrapperDto({
    PasswordComplexityResponseDto? setting,
  }) = _PasswordComplexityWrapperDto;

  factory PasswordComplexityWrapperDto.fromJson(Map<String, dynamic> json) =>
      _$PasswordComplexityWrapperDtoFromJson(json);
}

//* Tenant available response
@freezed
abstract class TenantAvailableResponseDto with _$TenantAvailableResponseDto {
  const factory TenantAvailableResponseDto({
    int? tenantId,
  }) = _TenantAvailableResponseDto;

  factory TenantAvailableResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TenantAvailableResponseDtoFromJson(json);
}

//* Authenticate response
@freezed
abstract class AuthenticateResponseDto with _$AuthenticateResponseDto {
  const factory AuthenticateResponseDto({
    required String accessToken,
    String? encryptedAccessToken,
    int? expireInSeconds,
    int? userId,
  }) = _AuthenticateResponseDto;

  factory AuthenticateResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateResponseDtoFromJson(json);
}

