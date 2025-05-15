import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iframe_cashpay/iframe_cashpay.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  testWidgets('IframeCashPay renders WebView', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: IframeCashPay(
          iframeURL: 'https://pay.cashpay.sa',
          onConfirmPayment: (_) {},
          onCancel: (_) {},
          onError: (_) {},
        ),
      ),
    );

    expect(find.byType(InAppWebView), findsOneWidget);
  });

  testWidgets('Displays loading indicator', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: IframeCashPay(
          iframeURL: 'https://pay.cashpay.ye',
          onConfirmPayment: (_) {},
          onCancel: (_) {},
          onError: (_) {},
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
