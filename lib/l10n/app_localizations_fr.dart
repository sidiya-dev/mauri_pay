// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get phone_placeholder => 'Numéro de téléphone';

  @override
  String get phone_error_invalid => 'Numéro de téléphone invalide';

  @override
  String get phone_error_empty => 'Veuillez saisir un numéro de téléphone';

  @override
  String get password_placeholder => 'Mot de passe';

  @override
  String get password_error_invalid =>
      'Le mot de passe doit comporter 4 chiffres';

  @override
  String get password_error_empty => 'Veuillez saisir un mot de passe';

  @override
  String get login_error_invalid =>
      'Numéro de téléphone ou mot de passe invalide';

  @override
  String get confirm_password_placeholder => 'Confirmer le mot de passe';

  @override
  String get dont_have_account => 'Vous n\'avez pas de compte ?';

  @override
  String get already_have_account => 'Vous avez déjà un compte ?';

  @override
  String get sign_in => 'Se connecter';

  @override
  String get sign_up => 'S\'inscrire';

  @override
  String get sold => 'Solde';

  @override
  String get request_money => 'Demander de l\'argent';

  @override
  String get transfer => 'Transférer';

  @override
  String get home => 'Accueil';

  @override
  String get transactions => 'Transactions';

  @override
  String get profile => 'Profil';

  @override
  String get logout => 'Déconnexion';

  @override
  String get contacts => 'Contacts';

  @override
  String get agencies => 'Agences';
}
