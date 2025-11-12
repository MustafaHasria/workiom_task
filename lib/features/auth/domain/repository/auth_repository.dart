import 'package:dartz/dartz.dart';
import 'package:workiom_task/features/auth/data/model/auth_models.dart';

//? Auth repository interface (abstract class)
abstract class AuthRepository {
  //* Get current login information
  Future<Either<String, LoginInfoModel>> getCurrentLoginInfo();

  //* Get available editions for registration
  Future<Either<String, EditionsModel>> getEditions();

  //* Get password complexity requirements
  Future<Either<String, PasswordComplexityModel>> getPasswordComplexity();

  //* Check if tenant name is available
  Future<Either<String, bool>> isTenantAvailable(String tenancyName);

  //* Register a new tenant with user
  Future<Either<String, void>> registerTenant({
    required String adminEmailAddress,
    required String adminFirstName,
    required String adminLastName,
    required String adminPassword,
    required int editionId,
    required String name,
    required String tenancyName,
    required String timeZone,
  });

  //* Authenticate user and get token
  Future<Either<String, String>> authenticate({
    required String userNameOrEmailAddress,
    required String password,
    required String tenantName,
    required String ianaTimeZone,
  });
}
