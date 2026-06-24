import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('ar'),
  ];

  /// No description provided for @nni_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your NNI'**
  String get nni_placeholder;

  /// No description provided for @nni_error_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid NNI'**
  String get nni_error_invalid;

  /// No description provided for @nni_error_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your NNI'**
  String get nni_error_empty;

  /// No description provided for @username_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get username_placeholder;

  /// No description provided for @username_error_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid username'**
  String get username_error_invalid;

  /// No description provided for @username_error_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your username'**
  String get username_error_empty;

  /// No description provided for @phone_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_placeholder;

  /// No description provided for @phone_error_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get phone_error_invalid;

  /// No description provided for @phone_error_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter a phone number'**
  String get phone_error_empty;

  /// No description provided for @password_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_placeholder;

  /// No description provided for @password_error_invalid.
  ///
  /// In en, this message translates to:
  /// **'Password must be 4 digits'**
  String get password_error_invalid;

  /// No description provided for @password_error_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get password_error_empty;

  /// No description provided for @password_mismatch_error.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get password_mismatch_error;

  /// No description provided for @password_unique_error.
  ///
  /// In en, this message translates to:
  /// **'Password must be 4 unique digits'**
  String get password_unique_error;

  /// No description provided for @login_error_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number or password'**
  String get login_error_invalid;

  /// No description provided for @confirm_password_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm_password_placeholder;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @sold.
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get sold;

  /// No description provided for @request_money.
  ///
  /// In en, this message translates to:
  /// **'Request Money'**
  String get request_money;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contacts;

  /// No description provided for @agencies.
  ///
  /// In en, this message translates to:
  /// **'Agencies'**
  String get agencies;

  /// No description provided for @error_invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number or password'**
  String get error_invalid_credentials;

  /// No description provided for @error_account_locked.
  ///
  /// In en, this message translates to:
  /// **'Account locked after too many attempts. Please try again later.'**
  String get error_account_locked;

  /// No description provided for @error_phone_already_exists.
  ///
  /// In en, this message translates to:
  /// **'This phone number is already registered'**
  String get error_phone_already_exists;

  /// No description provided for @error_recipient_not_found.
  ///
  /// In en, this message translates to:
  /// **'Recipient not found'**
  String get error_recipient_not_found;

  /// No description provided for @error_insufficient_balance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient balance'**
  String get error_insufficient_balance;

  /// No description provided for @error_self_transfer.
  ///
  /// In en, this message translates to:
  /// **'You cannot transfer to yourself'**
  String get error_self_transfer;

  /// No description provided for @error_network.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection.'**
  String get error_network;

  /// No description provided for @error_unexpected.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get error_unexpected;

  /// No description provided for @error_payment_not_found.
  ///
  /// In en, this message translates to:
  /// **'Invalid or unknown payment code'**
  String get error_payment_not_found;

  /// No description provided for @error_payment_already_paid.
  ///
  /// In en, this message translates to:
  /// **'This payment was already completed'**
  String get error_payment_already_paid;

  /// No description provided for @error_payment_expired.
  ///
  /// In en, this message translates to:
  /// **'This payment code has expired'**
  String get error_payment_expired;

  /// No description provided for @error_payment_not_payable.
  ///
  /// In en, this message translates to:
  /// **'This payment can no longer be paid'**
  String get error_payment_not_payable;

  /// No description provided for @error_invalid_password.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get error_invalid_password;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @pay_enter_code_title.
  ///
  /// In en, this message translates to:
  /// **'Enter the payment code'**
  String get pay_enter_code_title;

  /// No description provided for @pay_code_hint.
  ///
  /// In en, this message translates to:
  /// **'Payment code'**
  String get pay_code_hint;

  /// No description provided for @pay_code_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter the payment code'**
  String get pay_code_required;

  /// No description provided for @pay_amount_to_pay.
  ///
  /// In en, this message translates to:
  /// **'Amount to pay'**
  String get pay_amount_to_pay;

  /// No description provided for @pay_merchant.
  ///
  /// In en, this message translates to:
  /// **'Merchant'**
  String get pay_merchant;

  /// No description provided for @pay_code_label.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get pay_code_label;

  /// No description provided for @pay_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password to confirm'**
  String get pay_enter_password;

  /// No description provided for @pay_confirm.
  ///
  /// In en, this message translates to:
  /// **'Pay now'**
  String get pay_confirm;

  /// No description provided for @pay_success.
  ///
  /// In en, this message translates to:
  /// **'Payment successful'**
  String get pay_success;

  /// No description provided for @pay_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get pay_done;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
