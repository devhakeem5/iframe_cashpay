import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class IframeCashPay extends StatefulWidget {
  final String iframeURL;
  final Function(String) onConfirmPayment;
  final Function(String) onCancel;
  final Function(String) onError;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const IframeCashPay({
    super.key,
    required this.iframeURL,
    required this.onConfirmPayment,
    required this.onCancel,
    required this.onError,
    this.loadingWidget,
    this.errorWidget,
  });

  @override
  State<IframeCashPay> createState() => IframeCashPayState();
}

class IframeCashPayState extends State<IframeCashPay> {
  late InAppWebViewController _webViewController;
  final GlobalKey webViewKey = GlobalKey();

  bool isLoading = true;
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
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
                controller.addJavaScriptHandler(
                  handlerName: 'flutter',
                  callback: (args) {
                    handleMessage(args[0]);
                  },
                );
              },
              onLoadStart: (controller, url) {
                setState(() {
                  isLoading = true;
                  hasError = false;
                });
              },

              onLoadStop: (controller, url) async {
                setState(() {
                  isLoading = false;
                });
              },
              // ignore: deprecated_member_use
              onLoadError: (controller, url, code, message) {
                setState(() {
                  hasError = true;
                  isLoading = false;
                });
                widget.onError("Error");
              },
              onReceivedHttpError: (controller, request, response) {
                setState(() {
                  hasError = true;
                  isLoading = false;
                });
                widget.onError("Error");
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  isLoading = progress < 100;
                });
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                return NavigationActionPolicy.ALLOW;
              },
            ),

            // عرض مؤشر التحميل
            if (isLoading)
              Center(
                child:
                    widget.loadingWidget ?? const CircularProgressIndicator(),
              ),

            // عرض رسالة الخطأ مع خيار إعادة المحاولة
            if (hasError)
              Center(
                child:
                    widget.errorWidget ??
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 48),
                        const SizedBox(height: 12),
                        const Text(
                          "حدث خطأ أثناء تحميل الصفحة",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _retryLoad,
                          child: const Text("إعادة المحاولة"),
                        ),
                      ],
                    ),
              ),
          ],
        ),
      ),
    );
  }

  void _retryLoad() {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    _webViewController.loadUrl(
      urlRequest: URLRequest(url: WebUri(widget.iframeURL)),
    );
  }

  void handleMessage(String message) {
    if (message == "Confirmation") {
      widget.onConfirmPayment(message);
      Navigator.of(context).pop();
    } else if (message == "NEEDTOCHECK") {
      widget.onConfirmPayment(message);
      Navigator.of(context).pop();
    } else if (message == "Cancel") {
      widget.onCancel(message);
      Navigator.of(context).pop();
    } else if (message == "Error") {
      widget.onError(message);
    }
  }
}
