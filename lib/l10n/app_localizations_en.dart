// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get nni_placeholder => 'Enter your NNI';

  @override
  String get nni_error_invalid => 'Invalid NNI';

  @override
  String get nni_error_empty => 'Please enter your NNI';

  @override
  String get username_placeholder => 'Enter your username';

  @override
  String get username_error_invalid => 'Invalid username';

  @override
  String get username_error_empty => 'Please enter your username';

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
  String get password_mismatch_error => 'Passwords do not match';

  @override
  String get password_unique_error => 'Password must be 4 unique digits';

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

  @override
  String get error_invalid_credentials => 'Invalid phone number or password';

  @override
  String get error_account_locked =>
      'Account locked after too many attempts. Please try again later.';

  @override
  String get error_phone_already_exists =>
      'This phone number is already registered';

  @override
  String get error_recipient_not_found => 'Recipient not found';

  @override
  String get error_insufficient_balance => 'Insufficient balance';

  @override
  String get error_self_transfer => 'You cannot transfer to yourself';

  @override
  String get error_network => 'Network error. Please check your connection.';

  @override
  String get error_unexpected => 'Something went wrong. Please try again.';

  @override
  String get error_payment_not_found => 'Invalid or unknown payment code';

  @override
  String get error_payment_already_paid => 'This payment was already completed';

  @override
  String get error_payment_expired => 'This payment code has expired';

  @override
  String get error_payment_not_payable => 'This payment can no longer be paid';

  @override
  String get error_invalid_password => 'Incorrect password';

  @override
  String get pay => 'Pay';

  @override
  String get next => 'Next';

  @override
  String get pay_enter_code_title => 'Enter the payment code';

  @override
  String get pay_code_hint => 'Payment code';

  @override
  String get pay_code_required => 'Please enter the payment code';

  @override
  String get pay_amount_to_pay => 'Amount to pay';

  @override
  String get pay_merchant => 'Merchant';

  @override
  String get pay_code_label => 'Code';

  @override
  String get pay_enter_password => 'Enter your password to confirm';

  @override
  String get pay_confirm => 'Pay now';

  @override
  String get pay_success => 'Payment successful';

  @override
  String get pay_done => 'Done';

  @override
  String get deposit => 'Deposit';

  @override
  String get deposit_amount_hint => 'Amount to deposit';

  @override
  String get deposit_button => 'Deposit';

  @override
  String get deposit_success => 'Deposit successful';

  @override
  String get amount_error_empty => 'Amount is required';

  @override
  String get amount_error_invalid => 'Enter a valid amount';
}
