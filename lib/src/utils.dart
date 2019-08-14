import 'package:flutter_firebase_auth_ui/generated/i18n.dart';

// TODO: translate
String i18nErrorCode(context, errorCode) {
  I18n i18n = I18n.of(context);
  switch (errorCode) {
    case 'ERROR_USER_NOT_FOUND':
      return "Cette adresse email ne correspond à aucun compte";
    case 'ERROR_INVALID_EMAIL':
      return "Cette adresse email n'est pas valide.";
    case 'ERROR_WRONG_PASSWORD':
      return "Le mot de passe est erroné";
    case 'ERROR_USER_DISABLED':
      return "Votre compte est désactivé.";
    case 'ERROR_TOO_MANY_REQUESTS':
      return "Trop de tentatives ont été effectuées.";
    case 'ERROR_OPERATION_NOT_ALLOWED':
      return "Opération non autorisée.";
    case 'ERROR_WEAK_PASSWORD':
      return "Mot de passe trop faible.";
    case 'ERROR_EMAIL_ALREADY_IN_USE':
      return "Adresse email déjà utilisé.";
    default:
      return i18n.unknownError;
  }
}
