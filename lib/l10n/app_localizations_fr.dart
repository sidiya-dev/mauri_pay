// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get nni_placeholder => 'Entrez votre NNI';

  @override
  String get nni_error_invalid => 'NNI invalide';

  @override
  String get nni_error_empty => 'Veuillez entrer votre NNI';

  @override
  String get username_placeholder => 'Entrez votre nom d\'utilisateur';

  @override
  String get username_error_invalid => 'Nom d\'utilisateur invalide';

  @override
  String get username_error_empty => 'Veuillez entrer votre nom d\'utilisateur';

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
  String get password_mismatch_error =>
      'Les mots de passe ne correspondent pas';

  @override
  String get password_unique_error =>
      'Le mot de passe doit comporter 4 chiffres uniques';

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

  @override
  String get error_invalid_credentials =>
      'Numéro de téléphone ou mot de passe invalide';

  @override
  String get error_account_locked =>
      'Compte verrouillé après trop de tentatives. Veuillez réessayer plus tard.';

  @override
  String get error_phone_already_exists =>
      'Ce numéro de téléphone est déjà enregistré';

  @override
  String get error_recipient_not_found => 'Destinataire introuvable';

  @override
  String get error_insufficient_balance => 'Solde insuffisant';

  @override
  String get error_self_transfer =>
      'Vous ne pouvez pas transférer vers vous-même';

  @override
  String get error_network => 'Erreur réseau. Vérifiez votre connexion.';

  @override
  String get error_unexpected =>
      'Une erreur s\'est produite. Veuillez réessayer.';

  @override
  String get error_payment_not_found => 'Code de paiement invalide ou inconnu';

  @override
  String get error_payment_already_paid => 'Ce paiement a déjà été effectué';

  @override
  String get error_payment_expired => 'Ce code de paiement a expiré';

  @override
  String get error_payment_not_payable => 'Ce paiement ne peut plus être réglé';

  @override
  String get error_invalid_password => 'Mot de passe incorrect';

  @override
  String get pay => 'Payer';

  @override
  String get next => 'Suivant';

  @override
  String get pay_enter_code_title => 'Saisissez le code de paiement';

  @override
  String get pay_code_hint => 'Code de paiement';

  @override
  String get pay_code_required => 'Veuillez saisir le code de paiement';

  @override
  String get pay_amount_to_pay => 'Montant à payer';

  @override
  String get pay_merchant => 'Marchand';

  @override
  String get pay_code_label => 'Code';

  @override
  String get pay_enter_password =>
      'Saisissez votre mot de passe pour confirmer';

  @override
  String get pay_confirm => 'Payer maintenant';

  @override
  String get pay_success => 'Paiement réussi';

  @override
  String get pay_done => 'Terminé';
}
