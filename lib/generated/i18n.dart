import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

//WARNING: This file is automatically generated. DO NOT EDIT, all your changes would be lost.

typedef void LocaleChangeCallback(Locale locale);

class I18n implements WidgetsLocalizations {
  const I18n();
  static Locale _locale;
  static bool _shouldReload = false;

  static set locale(Locale _newLocale) {
    _shouldReload = true;
    I18n._locale = _newLocale;
  }

  static const GeneratedLocalizationsDelegate delegate = const GeneratedLocalizationsDelegate();

  /// function to be invoked when changing the language
  static LocaleChangeCallback onLocaleChanged;

  static I18n of(BuildContext context) => Localizations.of<I18n>(context, WidgetsLocalizations);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  /// "This email address doesn't match an account."
  String get error_user_not_found => "This email address doesn't match an account.";

  /// "This email address isn't valid."
  String get error_invalid_email => "This email address isn't valid.";

  /// "The password doesn't match."
  String get error_wrong_password => "The password doesn't match.";

  /// "Account disabled."
  String get error_user_disabled => "Account disabled.";

  /// "Too much tries, please retry later."
  String get error_too_many_requests => "Too much tries, please retry later.";

  /// "Operation not allowed."
  String get error_operation_not_allowed => "Operation not allowed.";

  /// "Too weak password."
  String get error_weak_password => "Too weak password.";

  /// "An account already use this email address."
  String get error_email_already_in_use => "An account already use this email address.";

  /// "Sign in"
  String get signIn => "Sign in";

  /// "Check"
  String get check => "Check";

  /// "Email"
  String get email => "Email";

  /// "Password"
  String get password => "Password";

  /// "Unknown error"
  String get unknownError => "Unknown error";

  /// "Validation code request in progress..."
  String get codeRequestInProgress => "Validation code request in progress...";

  /// "Verification code sent,\nwaiting for receipt..."
  String get codeRequestSent => "Verification code sent,\nwaiting for receipt...";

  /// "Code verified!\nAuthentication in progress..."
  String get codeCheckedAuthInProgress => "Code verified!\nAuthentication in progress...";

  /// "Can not check the code.\nDo you have a network?"
  String get unableToVerifyCode => "Can not check the code.\nDo you have a network?";

  /// "Please specify your phone number."
  String get phoneFieldEmpty => "Please specify your phone number.";

  /// "International format required"
  String get phoneFormatError => "International format required";

  /// "Please specify your email address"
  String get emailFieldEmpty => "Please specify your email address";

  /// "Please specify a password"
  String get passwordFieldEmpty => "Please specify a password";

  /// "Password forgotten"
  String get forgottenPassword => "Password forgotten";

  /// "Register"
  String get register => "Register";

  /// "Create"
  String get create => "Create";

  /// "Repeat password"
  String get repeatPassword => "Repeat password";

  /// "Please repeate your password"
  String get repeatPasswordFieldEmpty => "Please repeate your password";

  /// "Passwords do not match"
  String get passwordsDontMatch => "Passwords do not match";

  /// "Password reset!\nYou will receive an email in the next few minutes."
  String get passwordResetSuccess => "Password reset!\nYou will receive an email in the next few minutes.";

  /// "Reset"
  String get reset => "Reset";
}

class _I18n_en_US extends I18n {
  const _I18n_en_US();

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class _I18n_fr_FR extends I18n {
  const _I18n_fr_FR();

  /// "Cette adresse email ne correspond à aucun compte."
  @override
  String get error_user_not_found => "Cette adresse email ne correspond à aucun compte.";

  /// "Cette adresse email n'est pas valide."
  @override
  String get error_invalid_email => "Cette adresse email n'est pas valide.";

  /// "Le mot de passe est erroné."
  @override
  String get error_wrong_password => "Le mot de passe est erroné.";

  /// "Votre compte est désactivé."
  @override
  String get error_user_disabled => "Votre compte est désactivé.";

  /// "Trop de tentatives ont été effectuées."
  @override
  String get error_too_many_requests => "Trop de tentatives ont été effectuées.";

  /// "Opération non autorisée."
  @override
  String get error_operation_not_allowed => "Opération non autorisée.";

  /// "Mot de passe trop faible."
  @override
  String get error_weak_password => "Mot de passe trop faible.";

  /// "Adresse email déjà utilisé."
  @override
  String get error_email_already_in_use => "Adresse email déjà utilisé.";

  /// "Se connecter"
  @override
  String get signIn => "Se connecter";

  /// "Vérifier"
  @override
  String get check => "Vérifier";

  /// "Email"
  @override
  String get email => "Email";

  /// "Mot de passe"
  @override
  String get password => "Mot de passe";

  /// "Erreur inconnue"
  @override
  String get unknownError => "Erreur inconnue";

  /// "Demande de code en cours..."
  @override
  String get codeRequestInProgress => "Demande de code en cours...";

  /// "Code de vérification envoyé,\nen attente de réception..."
  @override
  String get codeRequestSent => "Code de vérification envoyé,\nen attente de réception...";

  /// "Code vérifié !\nAuthentification en cours..."
  @override
  String get codeCheckedAuthInProgress => "Code vérifié !\nAuthentification en cours...";

  /// "Impossible de vérifier le code.\nAvez-vous du réseau ?"
  @override
  String get unableToVerifyCode => "Impossible de vérifier le code.\nAvez-vous du réseau ?";

  /// "Merci de préciser votre numéro de téléphone"
  @override
  String get phoneFieldEmpty => "Merci de préciser votre numéro de téléphone";

  /// "Format international requis"
  @override
  String get phoneFormatError => "Format international requis";

  /// "Merci de préciser votre adresse email"
  @override
  String get emailFieldEmpty => "Merci de préciser votre adresse email";

  /// "Merci de préciser un mot de passe"
  @override
  String get passwordFieldEmpty => "Merci de préciser un mot de passe";

  /// "Mot de passe oublié"
  @override
  String get forgottenPassword => "Mot de passe oublié";

  /// "Créer un compte"
  @override
  String get register => "Créer un compte";

  /// "Créer"
  @override
  String get create => "Créer";

  /// "Répéter le mot de passe"
  @override
  String get repeatPassword => "Répéter le mot de passe";

  /// "Merci de répéter le mot de passe"
  @override
  String get repeatPasswordFieldEmpty => "Merci de répéter le mot de passe";

  /// "Les mots de passe ne correspondent pas"
  @override
  String get passwordsDontMatch => "Les mots de passe ne correspondent pas";

  /// "Mot de passe réinitialisé !\nVous allez recevoir un mail dans les prochaines minutes."
  @override
  String get passwordResetSuccess => "Mot de passe réinitialisé !\nVous allez recevoir un mail dans les prochaines minutes.";

  /// "Réinitialiser"
  @override
  String get reset => "Réinitialiser";

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();
  List<Locale> get supportedLocales {
    return const <Locale>[const Locale("en", "US"), const Locale("fr", "FR")];
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      if (this.isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale _locale) {
    I18n._locale ??= _locale;
    I18n._shouldReload = false;
    final Locale locale = I18n._locale;
    final String lang = locale != null ? locale.toString() : "";
    final String languageCode = locale != null ? locale.languageCode : "";
    if ("en_US" == lang) {
      return new SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    } else if ("fr_FR" == lang) {
      return new SynchronousFuture<WidgetsLocalizations>(const _I18n_fr_FR());
    } else if ("en" == languageCode) {
      return new SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    } else if ("fr" == languageCode) {
      return new SynchronousFuture<WidgetsLocalizations>(const _I18n_fr_FR());
    }

    return new SynchronousFuture<WidgetsLocalizations>(const I18n());
  }

  @override
  bool isSupported(Locale locale) {
    for (var i = 0; i < supportedLocales.length && locale != null; i++) {
      final l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => I18n._shouldReload;
}
