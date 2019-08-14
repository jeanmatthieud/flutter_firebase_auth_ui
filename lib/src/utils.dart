import 'package:flutter_firebase_auth_ui/generated/i18n.dart';

// TODO: translate
String i18nErrorCode(context, errorCode) {
  I18n i18n = I18n.of(context);
  switch (errorCode) {
    case 'ERROR_USER_NOT_FOUND':
      return i18n.error_user_not_found;
    case 'ERROR_INVALID_EMAIL':
      return i18n.error_invalid_email;
    case 'ERROR_WRONG_PASSWORD':
      return i18n.error_wrong_password;
    case 'ERROR_USER_DISABLED':
      return i18n.error_user_disabled;
    case 'ERROR_TOO_MANY_REQUESTS':
      return i18n.error_too_many_requests;
    case 'ERROR_OPERATION_NOT_ALLOWED':
      return i18n.error_operation_not_allowed;
    case 'ERROR_WEAK_PASSWORD':
      return i18n.error_weak_password;
    case 'ERROR_EMAIL_ALREADY_IN_USE':
      return i18n.error_email_already_in_use;
    default:
      return i18n.unknownError;
  }
}
