import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:dima/widgets/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class PaymentDetailsPage extends StatefulWidget {
  const PaymentDetailsPage(
      {Key? key, required this.name, required this.location})
      : super(key: key);
  final String name;
  final String location;
  @override
  State<PaymentDetailsPage> createState() => PaymentDetailsPageState();
}

class PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _CCController = TextEditingController();
  final TextEditingController _CVVController = TextEditingController();
  final TextEditingController _nameInputController = TextEditingController();

  String? _CCValidator(String? string) {
    return string!.length != 16 ? 'Credit card only has 16 digits' : null;
  }

  String? _CVVValidator(String? string) {
    return string!.length != 3 ? 'CVV only has 3 digits' : null;
  }

  void _confirmPayment() async {
    bool success = await sendPayment();
    success ? emptyCart() : _doNothing(true);

    /// TODO: Change this to pop until: ...
    SecondaryNavigator.pop(context);
  }

  emptyCart() {}
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
  void _doNothing(bool? value) {
    checkboxValue = !checkboxValue;
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
                child: Checkbox(value: checkboxValue, onChanged: _doNothing)),
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
