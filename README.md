# iframe_cashpay

![Pub Version](https://img.shields.io/pub/v/iframe_cashpay?style=flat-square)
![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.0.0-blue?style=flat-square&logo=flutter)
![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS-brightgreen?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)

**Flutter plugin for seamless CashPay wallet payments via iframe**

A modified package optimized for CashPay wallet transactions with enhanced JavaScript communication using `flutter_inappwebview`.

## ✨ Key Features

- 🔒 **CashPay Wallet Exclusive** - Dedicated integration for CashPay payment system
- 📱 **Cross-Platform** - Fully compatible with Android & iOS
- 🔄 **Bi-directional Communication** - Real-time payment status updates
- 🛡 **Secure Transactions** - PCI-compliant iframe implementation
- ⚡ **Lightweight** - Minimal footprint with maximum performance

## 🚀 Compatibility

| Platform | Minimum Version |
|----------|-----------------|
| Android  | API 19 (KitKat) |
| iOS      | 11.0+           |

## Usage

To start using this plugin, add `iframe_cashpay` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/):

```yaml
dependencies:
  iframe_cashpay: ^1.0.0
```

## 🔄 JavaScript Communication

### From Flutter to JavaScript
```dart
// Get the controller
final controller = await _webViewController.future;

// Execute JS
controller.evaluateJavascript(source:
  document.getElementById('amount').value = '100';);
```

### From JavaScript to Flutter
```JavaScript
// Standard CashPay Messages
window.flutter.postMessage('Confirmation');  // Payment success
window.flutter.postMessage('Cancel');        // User cancelled
window.flutter.postMessage('Error');         // Transaction failed

// Custom Data (JSON format recommended)
window.flutter.postMessage(JSON.stringify({
  event: 'payment_processed',
  orderId: '12345',
  amount: 100.00
}));
```
### Handling Custom Messages
```dart
IframeCashPay(
  // ...required parameters
  onMessage: (jsonString) {               // Handle custom JSON messages
    final data = jsonDecode(jsonString);
    print('Received: ${data['event']}');
  },
)
```

## Example

```dart
import 'package:iframe_cashpay/iframe_cashpay.dart';

class PaySampleAppState extends State<PaySampleApp> {
  


  @override
  Widget build(BuildContext context) {
    Future<String> payItems(itemList) async {
    //Send itemList for yor server and post CreateOrder.
    //iframeURL returned from Response CreateOrder
    //Documentation https://documenter.getpostman.com/view/17550185/2s93XzwN9o
    //String iframeURL = "**********************************************************";
    return iframeURL;
  }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Colors.white,
        body: ListView(children: [
          ElevatedButton(
              child: const Text('الدفع عبر كاش باي'),
              onPressed: () async {
                await payItems({
                  {
                    "itemName": "S24 Ultra",
                    "amount": 2000,
                  },
                  {
                    "itemName": "iPhone 15 PRO",
                    "amount": 5000,
                  }
                }).then((iframeURL) => showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.0),
                      ),
                    ),
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0),
                          height: MediaQuery.of(context).size.height * 0.7,
                          //IframeCashPay SDK to use iFrame CashPay
                          child: IframeCashPay(
                            iframeURL: iframeURL,
                            onConfirmPayment: onConfirmPayment,
                            onCancel: onCancel,
                            onError: onError,
                          ));
                    }));
              }),
        ]));
  }

  //Await for iFrameCashPay
  onConfirmPayment(message) {
    Navigator.pop(context);
    //After Confirmatin from iFrameCashPay.
    //Here use CheckOrderStatus to check order status.
    //Documentation https://documenter.getpostman.com/view/17550185/2s93XzwN9o
  }

//Await for iFrameCashPay
  onCancel(message) {
    //After Cancel from iFrameCashPay.
    Navigator.pop(context);
  }

//Await for iFrameCashPay
  onError(message) {
    //After return Error from iFrameCashPay.
    Navigator.pop(context);
  }
}
```
Made with ❤️ by Dev-HaKeeM Al-Najjar + AI | (https://www.facebook.com/share/1APVa9LvEP/)