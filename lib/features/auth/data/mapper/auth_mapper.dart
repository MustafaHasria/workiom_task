import 'package:workiom_task/features/auth/data/model/auth_models.dart';



//* Login Info Mapping
extension LoginInfoResponseDtoMapper on LoginInfoResponseDto {
  LoginInfoModel mapFromModel() {
    return LoginInfoModel(
      user: user?.mapFromModel(),
      tenant: tenant?.mapFromModel(),
    );
  }
}

extension UserResponseDtoMapper on UserResponseDto {
  UserModel mapFromModel() {
    return UserModel(
      id: id,
      name: name,
      surname: surname,
      userName: userName,
      emailAddress: emailAddress,
    );
  }
}

extension TenantResponseDtoMapper on TenantResponseDto {
  TenantModel mapFromModel() {
    return TenantModel(
      id: id,
      tenancyName: tenancyName,
      name: name,
    );
  }
}

//* Edition Mapping
extension EditionResponseDtoMapper on EditionResponseDto {
  EditionModel mapFromModel() {
    return EditionModel(
      id: id ?? 0,
      displayName: displayName ?? '',
      isRegistrable: isRegistrable,
      annualPrice: annualPrice?.toDouble(),
      monthlyPrice: monthlyPrice?.toDouble(),
      hasTrial: hasTrial,
      isMostPopular: isMostPopular ?? false,
    );
  }
}

extension EditionWithFeaturesDtoMapper on EditionWithFeaturesDto {
  EditionModel mapFromModel() {
    return edition?.mapFromModel() ?? EditionModel(
      id: 0,
      displayName: '',
      isRegistrable: false,
      annualPrice: null,
      monthlyPrice: null,
      hasTrial: false,
      isMostPopular: false,
    );
  }
}

extension EditionsResponseDtoMapper on EditionsResponseDto {
  EditionsModel mapFromModel() {
    return EditionsModel(
      editionsWithFeatures: editionsWithFeatures
          ?.map((dto) => dto.mapFromModel())
          .toList() ?? [],
    );
  }
}

//* Password Complexity Mapping
extension PasswordComplexityResponseDtoMapper on PasswordComplexityResponseDto {
  PasswordComplexityModel mapFromModel() {
    return PasswordComplexityModel(
      requireDigit: requireDigit,
      requireLowercase: requireLowercase,
      requireNonAlphanumeric: requireNonAlphanumeric,
      requireUppercase: requireUppercase,
      requiredLength: requiredLength,
    );
  }
}
