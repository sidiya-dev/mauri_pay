// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get nni_placeholder => 'أدخل رقم الهوية الوطنية';

  @override
  String get nni_error_invalid => 'رقم الهوية غير صالح';

  @override
  String get nni_error_empty => 'الرجاء إدخال رقم الهوية';

  @override
  String get username_placeholder => 'أدخل اسم المستخدم';

  @override
  String get username_error_invalid => 'اسم المستخدم غير صالح';

  @override
  String get username_error_empty => 'الرجاء إدخال اسم المستخدم';

  @override
  String get phone_placeholder => 'رقم الهاتف';

  @override
  String get phone_error_invalid => 'رقم الهاتف غير صالح';

  @override
  String get phone_error_empty => 'الرجاء إدخال رقم الهاتف';

  @override
  String get password_placeholder => 'كلمة المرور';

  @override
  String get password_error_invalid => 'يجب أن تكون كلمة المرور 4 أرقام';

  @override
  String get password_error_empty => 'الرجاء إدخال كلمة المرور';

  @override
  String get password_mismatch_error => 'كلمات المرور غير متطابقة';

  @override
  String get password_unique_error =>
      'يجب أن تحتوي كلمة المرور على 4 أرقام مختلفة';

  @override
  String get login_error_invalid => 'رقم الهاتف أو كلمة المرور غير صالح';

  @override
  String get confirm_password_placeholder => 'تأكيد كلمة المرور';

  @override
  String get dont_have_account => 'ليس لديك حساب؟';

  @override
  String get already_have_account => 'هل لديك حساب بالفعل؟';

  @override
  String get sign_in => 'تسجيل الدخول';

  @override
  String get sign_up => 'إنشاء حساب';

  @override
  String get sold => 'الرصيد';

  @override
  String get request_money => 'طلب الأموال';

  @override
  String get transfer => 'تحويل';

  @override
  String get home => 'الرئيسية';

  @override
  String get transactions => 'المعاملات';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get contacts => 'جهات الاتصال';

  @override
  String get agencies => 'الوكالات';
}
