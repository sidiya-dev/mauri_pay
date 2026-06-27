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

  @override
  String get error_invalid_credentials => 'رقم الهاتف أو كلمة المرور غير صحيحة';

  @override
  String get error_account_locked =>
      'تم قفل الحساب بعد عدة محاولات. يرجى المحاولة لاحقًا.';

  @override
  String get error_phone_already_exists => 'رقم الهاتف هذا مسجل بالفعل';

  @override
  String get error_recipient_not_found => 'المستلم غير موجود';

  @override
  String get error_insufficient_balance => 'الرصيد غير كافٍ';

  @override
  String get error_self_transfer => 'لا يمكنك التحويل إلى نفسك';

  @override
  String get error_network => 'خطأ في الشبكة. يرجى التحقق من اتصالك.';

  @override
  String get error_unexpected => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get error_payment_not_found => 'رمز الدفع غير صالح أو غير معروف';

  @override
  String get error_payment_already_paid => 'تم إتمام هذا الدفع بالفعل';

  @override
  String get error_payment_expired => 'انتهت صلاحية رمز الدفع هذا';

  @override
  String get error_payment_not_payable => 'لم يعد من الممكن دفع هذا الطلب';

  @override
  String get error_invalid_password => 'كلمة المرور غير صحيحة';

  @override
  String get pay => 'ادفع';

  @override
  String get next => 'التالي';

  @override
  String get pay_enter_code_title => 'أدخل رمز الدفع';

  @override
  String get pay_code_hint => 'رمز الدفع';

  @override
  String get pay_code_required => 'يرجى إدخال رمز الدفع';

  @override
  String get pay_amount_to_pay => 'المبلغ المطلوب دفعه';

  @override
  String get pay_merchant => 'التاجر';

  @override
  String get pay_code_label => 'الرمز';

  @override
  String get pay_enter_password => 'أدخل كلمة المرور للتأكيد';

  @override
  String get pay_confirm => 'ادفع الآن';

  @override
  String get pay_success => 'تم الدفع بنجاح';

  @override
  String get pay_done => 'تم';

  @override
  String get deposit => 'إيداع';

  @override
  String get deposit_amount_hint => 'المبلغ المراد إيداعه';

  @override
  String get deposit_button => 'إيداع';

  @override
  String get deposit_success => 'تم الإيداع بنجاح';

  @override
  String get amount_error_empty => 'المبلغ مطلوب';

  @override
  String get amount_error_invalid => 'أدخل مبلغاً صحيحاً';
}
