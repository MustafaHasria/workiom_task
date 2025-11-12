import 'package:dartz/dartz.dart';
import 'package:workiom_task/core/config/app_api.dart';
import 'package:workiom_task/core/network/network_client.dart';
import 'package:workiom_task/core/storage/token_storage.dart';
import 'package:workiom_task/features/auth/data/mapper/auth_mapper.dart';
import 'package:workiom_task/features/auth/data/model/auth_models.dart';
import 'package:workiom_task/features/auth/domain/repository/auth_repository.dart';

//? Auth repository implementation
class AuthRepositoryImpl implements AuthRepository {
  final NetworkClient _networkClient;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._networkClient, this._tokenStorage);

  @override
  Future<Either<String, LoginInfoModel>> getCurrentLoginInfo() async {
    final response = await _networkClient.get(AppApi.getCurrentLoginInfo);
    
    return response.fold(
      (error) => Left(error),
      (data) {
        try {
          final result = data['result'];
          final dto = LoginInfoResponseDto.fromJson(result);
          return Right(dto.mapFromModel());
        } catch (e) {
          return Left('Failed to parse login info: ${e.toString()}');
        }
      },
    );
  }

  @override
  Future<Either<String, EditionsModel>> getEditions() async {
    final response = await _networkClient.get(AppApi.getEditions);
    
    return response.fold(
      (error) => Left(error),
      (data) {
        try {
          final result = data['result'];
          final dto = EditionsResponseDto.fromJson(result);
          return Right(dto.mapFromModel());
        } catch (e) {
          return Left('Failed to parse editions: ${e.toString()}');
        }
      },
    );
  }

  @override
  Future<Either<String, PasswordComplexityModel>> getPasswordComplexity() async {
    final response = await _networkClient.get(AppApi.getPasswordComplexity);
    
    return response.fold(
      (error) => Left(error),
      (data) {
        try {
          final result = data['result'];
          final wrapper = PasswordComplexityWrapperDto.fromJson(result);
          if (wrapper.setting == null) {
            return const Left('Password complexity settings not found');
          }
          return Right(wrapper.setting!.mapFromModel());
        } catch (e) {
          return Left('Failed to parse password complexity: ${e.toString()}');
        }
      },
    );
  }

  @override
  Future<Either<String, bool>> isTenantAvailable(String tenancyName) async {
    final request = TenantAvailableRequestDto(tenancyName: tenancyName);
    final response = await _networkClient.post(
      AppApi.isTenantAvailable,
      data: request.toJson(),
    );
    
    return response.fold(
      (error) => Left(error),
      (data) {
        try {
          final result = data['result'];
          final dto = TenantAvailableResponseDto.fromJson(result);
          //* If tenantId is null, the tenant is available
          final isAvailable = dto.tenantId == null;
          return Right(isAvailable);
        } catch (e) {
          return Left('Failed to parse tenant availability: ${e.toString()}');
        }
      },
    );
  }

  @override
  Future<Either<String, void>> registerTenant({
    required String adminEmailAddress,
    required String adminFirstName,
    required String adminLastName,
    required String adminPassword,
    required int editionId,
    required String name,
    required String tenancyName,
    required String timeZone,
  }) async {
    final request = RegisterTenantRequestDto(
      adminEmailAddress: adminEmailAddress,
      adminFirstName: adminFirstName,
      adminLastName: adminLastName,
      adminPassword: adminPassword,
      captchaResponse: null,
      editionId: editionId,
      name: name,
      tenancyName: tenancyName,
    );
    
    final response = await _networkClient.post(
      AppApi.registerTenant,
      data: request.toJson(),
      queryParameters: {'timeZone': timeZone},
    );
    
    return response.fold(
      (error) => Left(error),
      (_) => const Right(null),
    );
  }

  @override
  Future<Either<String, String>> authenticate({
    required String userNameOrEmailAddress,
    required String password,
    required String tenantName,
    required String ianaTimeZone,
  }) async {
    final request = AuthenticateRequestDto(
      ianaTimeZone: ianaTimeZone,
      password: password,
      rememberClient: false,
      returnUrl: null,
      singleSignIn: false,
      tenantName: tenantName,
      userNameOrEmailAddress: userNameOrEmailAddress,
    );
    
    final response = await _networkClient.post(
      AppApi.authenticate,
      data: request.toJson(),
    );
    
    return response.fold(
      (error) => Left(error),
      (data) async {
        try {
          final result = data['result'];
          final dto = AuthenticateResponseDto.fromJson(result);
          //* Save token to storage
          await _tokenStorage.saveToken(dto.accessToken);
          return Right(dto.accessToken);
        } catch (e) {
          return Left('Failed to parse authentication: ${e.toString()}');
        }
      },
    );
  }
}
