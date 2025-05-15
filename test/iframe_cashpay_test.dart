import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iframe_cashpay/iframe_cashpay.dart';

void main() {
  group('URL Validation Tests', () {
    test('Valid CashPay URL', () {
      final widget = IframeCashPay(
        iframeURL: 'https://pay.cashpay.sa?order_id=123',
        onConfirmPayment: (_) {},
        onCancel: (_) {},
        onError: (_) {},
      );
      expect(widget.iframeURL, contains('cashpay.sa'));
    });

    test('Empty URL throws assertion', () {
      expect(
        () => IframeCashPay(
          iframeURL: '',
          onConfirmPayment: (_) {},
          onCancel: (_) {},
          onError: (_) {},
        ),
        throwsAssertionError,
      );
    });
  });

  group('Callback Tests', () {
    late bool paymentConfirmed;
    // ignore: unused_local_variable
    late bool paymentCancelled;

    setUp(() {
      paymentConfirmed = false;
      paymentCancelled = false;
    });

    testWidgets('Triggers onConfirmPayment', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: IframeCashPay(
            iframeURL: 'https://pay.cashpay.sa',
            onConfirmPayment: (_) => paymentConfirmed = true,
            onCancel: (_) {},
            onError: (_) {},
          ),
        ),
      );

      // Simulate JS message
      final context = tester.element(find.byType(IframeCashPay));
      context.findAncestorStateOfType<IframeCashPayState>()?.handleMessage('Confirmation');
      
      expect(paymentConfirmed, isTrue);
    });
  });
}