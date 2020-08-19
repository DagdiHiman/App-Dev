import 'package:flutter/material.dart';
import 'package:flutter_amazon_ui_redesign/models/product_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Razorpay razorpay;

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_fYt98GfBqShZsO",
      "amount": num.parse("336") * 100,
      "name": "Sample App",
      "description": "Payment for the some random product",
      "prefill": {"contact": "2323232323", "email": "shdjsdh@gmail.com"},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Payment success");
    Toast.show(
      "Payment success:" + response.paymentId,
      context,
      duration: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Payment error");
    Toast.show(
      "Payment error:" + response.code.toString() + "...\n" + response.message,
      context,
      duration: Toast.LENGTH_LONG,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
    Toast.show(
      "External Wallet: " + response.walletName,
      context,
      duration: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  _buildCartProduct(int index) {
    return ListTile(
      contentPadding: EdgeInsets.all(20.0),
      leading: Image(
        height: double.infinity,
        width: 100.0,
        image: AssetImage(
          cart[index].imageUrl,
        ),
        fit: BoxFit.contain,
      ),
      title: Text(
        cart[index].name,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'x1',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        '\$${cart[index].price.toStringAsFixed(2)}',
        style: TextStyle(
          color: Colors.deepOrange,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Shopping Cart (${cart.length})',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.separated(
        itemCount: cart.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildCartProduct(index);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[300],
          );
        },
      ),
      bottomSheet: Container(
        height: 80.0,
        color: Colors.deepOrange,
        child: Center(
          child: RaisedButton(
            onPressed: openCheckout,
            child: Text(
              'PLACE ORDER (\$336.39)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            color: Colors.orangeAccent,
          ),
        ),
      ),
    );
  }
}
