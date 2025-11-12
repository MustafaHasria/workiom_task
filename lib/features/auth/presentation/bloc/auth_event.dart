import 'package:equatable/equatable.dart';

//? Auth events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

//* Check login status
class CheckLoginStatusEvent extends AuthEvent {
  const CheckLoginStatusEvent();
}

//* Get editions for registration
class GetEditionsEvent extends AuthEvent {
  const GetEditionsEvent();
}

//* Get password complexity requirements
class GetPasswordComplexityEvent extends AuthEvent {
  const GetPasswordComplexityEvent();
}

//* Check tenant availability
class CheckTenantAvailabilityEvent extends AuthEvent {
  final String tenancyName;

  const CheckTenantAvailabilityEvent(this.tenancyName);

  @override
  List<Object?> get props => [tenancyName];
}

//* Register tenant
class RegisterTenantEvent extends AuthEvent {
  final String adminEmailAddress;
  final String adminFirstName;
  final String adminLastName;
  final String adminPassword;
  final int editionId;
  final String name;
  final String tenancyName;
  final String timeZone;

  const RegisterTenantEvent({
    required this.adminEmailAddress,
    required this.adminFirstName,
    required this.adminLastName,
    required this.adminPassword,
    required this.editionId,
    required this.name,
    required this.tenancyName,
    required this.timeZone,
  });

  @override
  List<Object?> get props => [
        adminEmailAddress,
        adminFirstName,
        adminLastName,
        adminPassword,
        editionId,
        name,
        tenancyName,
        timeZone,
      ];
}

//* Authenticate user
class AuthenticateEvent extends AuthEvent {
  final String userNameOrEmailAddress;
  final String password;
  final String tenantName;
  final String ianaTimeZone;

  const AuthenticateEvent({
    required this.userNameOrEmailAddress,
    required this.password,
    required this.tenantName,
    required this.ianaTimeZone,
  });

  @override
  List<Object?> get props => [
        userNameOrEmailAddress,
        password,
        tenantName,
        ianaTimeZone,
      ];
}

//* Validate email and password
class ValidateEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const ValidateEmailPasswordEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

//* Validate registration form
class ValidateRegistrationFormEvent extends AuthEvent {
  final String tenancyName;
  final String firstName;
  final String lastName;

  const ValidateRegistrationFormEvent({
    required this.tenancyName,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [tenancyName, firstName, lastName];
}

