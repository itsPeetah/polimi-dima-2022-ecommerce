// ignore_for_file: non_constant_identifier_names

import 'package:dima/util/database/database.dart';
import 'package:dima/util/navigation/navigation_main.dart';
import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';

class PaymentDetailsPage extends StatefulWidget {
  const PaymentDetailsPage(
      {Key? key,
      required this.name,
      required this.location,
      this.phone,
      required this.price})
      : super(key: key);
  final String name;
  final String location;
  final String? phone;
  final String price;
  @override
  State<PaymentDetailsPage> createState() => PaymentDetailsPageState();
}

class PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _CCController = TextEditingController();
  final TextEditingController _CVVController = TextEditingController();
  final TextEditingController _nameInputController = TextEditingController();
  TextStyle _style = TextStyle(color: Colors.transparent);
  String? _CCValidator(String? string) {
    return string!.length != 16 ? 'Credit card number is incorrect.' : null;
  }

  String? _CVVValidator(String? string) {
    return string!.length < 3 || string.length > 4 ? 'CVV is incorrect.' : null;
  }

  void _confirmPayment() async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    bool success = await sendPayment();
    List<Product> listOfProducts = [];
    for (Product p in DatabaseManager.cart.values) {
      if (p.qty > 0) {
        listOfProducts.add(p);
      }
    }
    if (success) {
      for (Product p in DatabaseManager.cart.values) {
        if (p.qty > 0) {
          DatabaseManager.updateUserHistoryFromProduct(p);
        }
      }
      DatabaseManager.emptyCart();
    } else {
      // TODO: Show error
      setState(() {
        _style = const TextStyle(color: Colors.red);
      });
      return;
    }

    setState(() {
      _style = const TextStyle(color: Colors.transparent);
    });
    var count = 0;
    // final r = MainNavigatorRouter.generateRoute(
    //     RouteSettings(name: MainNavigationRoutes.bankDetails, arguments: {
    //   'listOfProducts': listOfProducts,
    //   'location': widget.location,
    //   'price': widget.price,
    // }));
    MainNavigator.push(MainNavigationRoutes.thankYouPage, arguments: {
      'listOfProducts': listOfProducts,
      'location': widget.location,
      'price': widget.price
    });
    // MainNavigator.mainNavigatorKey.currentState!.push(r!);
    // SecondaryNavigator.push(context, NestedNavigatorRoutes.thankyoupage,
    //     routeArgs: {
    //       'listOfProducts': listOfProducts,
    //       'location': widget.location,
    //       'price': widget.price,
    //     });
    // Navigator.popUntil(context, (route) {
    //   return count++ == 2;
    // });
  }

  @override
  void dispose() {
    _CCController.dispose();
    _CVVController.dispose();
    _nameInputController.dispose();
    super.dispose();
  }

  Future<bool> sendPayment() async {
    await Future.delayed(const Duration(seconds: 1), () => {true});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [_creditCardDetailsForm()],
    );
  }

  bool checkboxValue = false;
  void _setName(bool? value) {
    checkboxValue = !checkboxValue;
    checkboxValue ? _nameInputController.text = widget.name : () {};
    setState(() {});
  }

  Widget _creditCardDetailsForm() {
    return Padding(
      padding: const EdgeInsets.all(24.00),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: _CCValidator,
              decoration: const InputDecoration(
                  hintText: "Enter your Credit Card number..."),
              controller: _CCController,
            ),
            TextFormField(
              validator: _CVVValidator,
              decoration: const InputDecoration(hintText: "Enter your CVV..."),
              controller: _CVVController,
            ),
            TextFormField(
              enabled: !checkboxValue,
              decoration: const InputDecoration(
                  hintText: "Enter the credit card owner name..."),
              controller: _nameInputController,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Tap below if same as destination'),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Checkbox(value: checkboxValue, onChanged: _setName)),
            Text(
              'Payment was not successful',
              style: _style,
            ),
            TextButtonLarge(
              text: "Continue",
              onPressed: _confirmPayment,
            ),
            TextButtonLarge(
              text: "Go back",
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
}
