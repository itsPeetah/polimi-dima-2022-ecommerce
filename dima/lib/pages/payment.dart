import 'package:dima/model/product.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:dima/util/database/database.dart';
import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:dima/main.dart';
import 'package:dima/util/database/list_of_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key, required this.showPage}) : super(key: key);
  final bool showPage;
  @override
  State<PaymentPage> createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _locationInputController =
      TextEditingController();
  final TextEditingController _phoneInputController = TextEditingController();

  @override
  void dispose() {
    _phoneInputController.dispose();
    _locationInputController.dispose();
    _nameInputController.dispose();
    super.dispose();
  }

  List<Widget> listOfItems = [];

  double checkOutSum = 0;

  String? _nameValidator(String? str) {
    return str == null || str.isEmpty
        ? "Please enter the receiver's name."
        : null;
  }

  String? _locationValidator(String? str) {
    final bool emailInvalid = str == null || str.isEmpty;
    return emailInvalid ? "Please enter a location." : null;
  }

  void _goToBankDetails() {
    if (_formKey.currentState!.validate()) {
      SecondaryNavigator.push(context, NestedNavigatorRoutes.bankDetails,
          routeArgs: {
            'name': _nameInputController.text,
            'location': _locationInputController.text,
            'phone': _phoneInputController.text,
            'price': checkOutSum.toString()
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: ((context, appState, _) {
        return _buildShoppingBody();
      }),
    );
  }

  Widget _buildShoppingBody() {
    setTotalPrice();
    List<Widget> footer = [
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.orange[50],
          child: const Divider(
            thickness: 2,
            indent: 5,
            endIndent: 5,
            height: 10,
            color: dividerColor,
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          'Total cost: ' + checkOutSum.toString() + '\$',
          style: const TextStyle(fontSize: productTitleSize),
        ),
      )
    ];
    if (widget.showPage) {
      getListOfItems();
      return Column(
        children: <Widget>[
              Expanded(
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: listOfItems +
                      [
                        personalInfoForm(),
                      ],
                ),
              ),
            ] +
            footer,
      );
    } else {
      return Column(
        children: <Widget>[
              Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    personalInfoForm(),
                  ],
                ),
              ),
            ] +
            footer,
      );
    }
  }

  Widget personalInfoForm() {
    return Padding(
      padding: const EdgeInsets.all(24.00),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                return _nameValidator(value);
              },
              decoration: const InputDecoration(
                  hintText: "Enter your name...",
                  errorStyle: TextStyle(fontSize: errorTextSize)),
              controller: _nameInputController,
            ),
            TextFormField(
              validator: _locationValidator,
              decoration: const InputDecoration(
                  hintText: "Enter your desired location...",
                  errorStyle: TextStyle(fontSize: errorTextSize)),
              controller: _locationInputController,
            ),
            TextFormField(
              decoration:
                  const InputDecoration(hintText: "Enter your phone number..."),
              controller: _phoneInputController,
            ),
            TextButtonLarge(
              text: "Continue",
              onPressed: _goToBankDetails,
            ),
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: smallButtonTextSize),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  bool headlineContained = false;
  static const Widget _headline =
      Center(child: Headline(text: 'All the items in check out '));

  void getListOfItems() {
    listOfItems = [];
    headlineContained = false;
    List<Widget> listOfWidgets = getItemsInCart();
    if (listOfWidgets.isNotEmpty) {
      if (!headlineContained) {
        listOfItems.add(_headline);
        headlineContained = true;
      }
    } else {
      headlineContained = false;
      listOfItems.remove(_headline);
    }
    for (var element in listOfWidgets) {
      listOfItems.add(element);
    }
  }

  void setTotalPrice() {
    Map<String, dynamic> products =
        DatabaseManager.cart as Map<String, dynamic>;

    Map<String, dynamic> productAsMap = products;
    double sum = 0;
    for (var key in productAsMap.keys) {
      Product prod = productAsMap[key];
      var priceAsString = prod.price;
      if (prod.qty > 0) {
        sum += prod.qty *
            double.parse(priceAsString.substring(0, priceAsString.length - 1));
      }
    }
    checkOutSum = sum;
  }
}
