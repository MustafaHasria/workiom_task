//? Tenant name validation utility
class TenantNameValidator {
  //* Validate tenant name format
  static bool isValid(String tenantName) {
    if (tenantName.isEmpty) return false;

    //* Must start with a letter
    if (!RegExp(r'^[a-zA-Z]').hasMatch(tenantName)) {
      return false;
    }

    //* Can contain letters, numbers, and dashes
    if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9-]*$').hasMatch(tenantName)) {
      return false;
    }

    return true;
  }

  static String? validate(String? tenantName) {
    if (tenantName == null || tenantName.isEmpty) {
      return 'Tenant name is required';
    }

    if (!RegExp(r'^[a-zA-Z]').hasMatch(tenantName)) {
      return 'Tenant name must start with a letter';
    }

    if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9-]*$').hasMatch(tenantName)) {
      return 'Tenant name can only contain letters, numbers, and dashes';
    }

    return null;
  }
}

