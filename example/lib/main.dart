import 'package:flutter/material.dart';
import 'package:iframe_cashpay/iframe_cashpay.dart';
import 'package:iframe_cashpay/cash_pay_button.dart';

void main() {
  runApp(const PayMaterialApp());
}

class PayMaterialApp extends StatelessWidget {
  const PayMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pay for Flutter Demo',
      home: PaySampleApp(title: 'PaySampleApp'),
    );
  }
}

class PaySampleApp extends StatefulWidget {
  final String title;
  const PaySampleApp({super.key, required this.title});

  @override
  State<PaySampleApp> createState() => PaySampleAppState();
}

class PaySampleAppState extends State<PaySampleApp> {
  String orderId = "";

  /// This function Send itemList for yor server.
  ///
  /// @param itemList.
  /// @return iframeURL and orderId.
  ///
  /// Example:
  ///
  /// ```
  /// var res = sendItems(itemList);
  /// print(res.then((iframeURL)=>iframeURL)); // "https://########"
  /// ```
  Future<String> sendItems(itemList) async {
    //Send itemList for yor server and post CreateOrder.
    //iframeURL returned from Response CreateOrder
    //Documentation https://documenter.getpostman.com/view/17550185/2s93XzwN9o
    String iframeURL = "";
    //orderID returned from Response CreateOrder
    //Store the orderID in the orderId variable to use on function onConfirmPayment
    orderId = "";
    return iframeURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          CashPayButton(
            width: MediaQuery.of(context).size.width,
            onTap: () async {
              await sendItems({
                {"itemName": "كتاب", "amount": 2000},
                {"itemName": "ساعة", "amount": 5000},
              }).then(
                (iframeURL) => showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.0),
                    ),
                  ),
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        top: 10.0,
                      ),
                      height: MediaQuery.of(context).size.height * 0.7,
                      //IframeCashPay widget displays the Cash E-wallet payment iframe.
                      /// This widget IframeCashPay displays the Cash E-wallet payment iframe.
                      ///
                      /// @param iframeURL .
                      /// @param onConfirmPayment.
                      /// @param onCancel.
                      /// @param onError.
                      /// @return message onConfirmPayment or onCancel or onError.
                      ///
                      /// Example:
                      ///
                      /// ```
                      ///  IframeCashPay( iframeURL: "https://########",
                      ///    onConfirmPayment: onConfirmPayment,
                      ///    onCancel: onCancel,
                      ///    onError: onError,);
                      /// ```
                      child: IframeCashPay(
                        iframeURL: iframeURL,
                        onConfirmPayment: onConfirmPayment,
                        onCancel: onCancel,
                        onError: onError,
                        loadingWidget: Center(child: CircularProgressIndicator(),),
                      ),
                      
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// This function callback onConfirmPayment.
  ///
  /// @param message.
  /// @return message onConfirmPayment.
  ///
  /// Example:
  ///
  /// ```
  /// onConfirmPayment("NEEDTOCHECK");
  /// ```
  onConfirmPayment(message) {
    if (orderId.isNotEmpty) {
      //After Confirmatin from iFrame Returned message {NEEDTOCHECK or Confirmation}.
      //if(message.messsage==NEEDTOCHECK || message.messsage==Confirmation)
      //Here use CheckOrderStatus to check order status.
      //Documentation https://documenter.getpostman.com/view/29850098/2s9YXcd5Fd
    }
  }

  /// This function callback onCancel.
  ///
  /// @param message.
  /// @return message onCancel.
  ///
  /// Example:
  ///
  /// ```
  /// onCancel("Cancel");
  /// ```
  onCancel(message) {
    //After Cancel from iFrameCashPay.
    Navigator.pop(context);
  }

  /// This function callback onError.
  ///
  /// @param message.
  /// @return message onError.
  ///
  /// Example:
  ///
  /// ```
  /// onError("Error");
  /// ```
  onError(message) {
    // //After return Error from iFrameCashPay.
    // Navigator.pop(context);
  }
}
