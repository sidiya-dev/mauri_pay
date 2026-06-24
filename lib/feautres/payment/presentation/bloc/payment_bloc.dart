import 'package:bloc/bloc.dart';
import 'package:mauri_pay/feautres/payment/domain/entities/payment_preview_entity.dart';
import 'package:mauri_pay/feautres/payment/domain/usecases/get_payment_preview.dart';
import 'package:mauri_pay/feautres/payment/domain/usecases/pay_code.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetPaymentPreview _getPreview;
  final PayCode _payCode;

  PaymentBloc({required GetPaymentPreview getPreview, required PayCode payCode})
      : _getPreview = getPreview,
        _payCode = payCode,
        super(PaymentInitial()) {
    on<LoadPreview>((event, emit) async {
      emit(PaymentLoading());
      final result = await _getPreview(event.code.trim());
      result.fold(
        (failure) => emit(PaymentFailure(failure.message, code: failure.code)),
        (preview) => emit(PaymentPreviewLoaded(preview)),
      );
    });

    on<PayRequested>((event, emit) async {
      final preview = _currentPreview();
      emit(PaymentPaying(preview));
      final result = await _payCode(
        PayCodeParams(code: event.code, password: event.password),
      );
      result.fold(
        (failure) =>
            emit(PaymentFailure(failure.message, code: failure.code, preview: preview)),
        (_) => emit(PaymentPaid(preview)),
      );
    });

    on<ResetPayment>((event, emit) => emit(PaymentInitial()));
  }

  PaymentPreviewEntity _currentPreview() {
    final s = state;
    if (s is PaymentPreviewLoaded) return s.preview;
    if (s is PaymentPaying) return s.preview;
    if (s is PaymentFailure && s.preview != null) return s.preview!;
    throw StateError('No preview loaded');
  }
}
