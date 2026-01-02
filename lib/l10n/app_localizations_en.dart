// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get phone_placeholder => 'Phone number';

  @override
  String get phone_error_invalid => 'Invalid phone number';

  @override
  String get phone_error_empty => 'Please enter a phone number';

  @override
  String get password_placeholder => 'Password';

  @override
  String get password_error_invalid => 'Password must be 4 digits';

  @override
  String get password_error_empty => 'Please enter a password';

  @override
  String get login_error_invalid => 'Invalid phone number or password';

  @override
  String get confirm_password_placeholder => 'Confirm password';

  @override
  String get dont_have_account => 'Don\'t have an account?';

  @override
  String get already_have_account => 'Already have an account?';

  @override
  String get sign_in => 'Sign In';

  @override
  String get sign_up => 'Sign Up';

  @override
  String get sold => 'Sold';

  @override
  String get request_money => 'Request Money';

  @override
  String get transfer => 'Transfer';

  @override
  String get home => 'Home';

  @override
  String get transactions => 'Transactions';

  @override
  String get profile => 'Profile';

  @override
  String get logout => 'Logout';

  @override
  String get contacts => 'Contacts';

  @override
  String get agencies => 'Agencies';
}
