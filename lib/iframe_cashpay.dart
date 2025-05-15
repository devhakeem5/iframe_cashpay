import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io';

class IframeCashPay extends StatefulWidget {
  final String iframeURL;
  final Function(String) onConfirmPayment;
  final Function(String) onCancel;
  final Function(String) onError;

  const IframeCashPay({
    super.key,
    required this.iframeURL,
    required this.onConfirmPayment,
    required this.onCancel,
    required this.onError,
  });

  @override
  State<IframeCashPay> createState() => IframeCashPayState();
}

class IframeCashPayState extends State<IframeCashPay> {
  // ignore: unused_field
  late InAppWebViewController _webViewController;
  final GlobalKey webViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      // تهيئة خاصة لأندرويد إذا لزم الأمر
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: WebUri(widget.iframeURL)),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            useShouldOverrideUrlLoading: true,
            mediaPlaybackRequiresUserGesture: true,
            useHybridComposition: true,
            allowsInlineMediaPlayback: true,
          ),
          onWebViewCreated: (controller) {
            _webViewController = controller;

            // إضافة JavaScript Channels
            controller.addJavaScriptHandler(
              handlerName: 'flutter',
              callback: (args) {
                handleMessage(args[0]);
              },
            );
          },
          onLoadStart: (controller, url) {
            debugPrint('Page started loading: $url');
          },
          onLoadStop: (controller, url) async {
            debugPrint('Page finished loading: $url');
          },
          onProgressChanged: (controller, progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            debugPrint(
              'allowing navigation to ${navigationAction.request.url}',
            );
            return NavigationActionPolicy.ALLOW;
          },
        ),
      ),
    );
  }

  void handleMessage(String message) {
    if (message == "Confirmation") {
      widget.onConfirmPayment(message);
    } else if (message == "NEEDTOCHECK") {
      Navigator.of(context).pop();
      widget.onConfirmPayment(message);
    } else if (message == "Cancel") {
      Navigator.of(context).pop();
      widget.onCancel(message);
    } else if (message == "Error") {
      widget.onError(message);
    }
  }
}
