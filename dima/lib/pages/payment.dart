import 'package:dima/model/product.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:dima/util/navigation/navigation_nested.dart';
import 'package:dima/widgets/misc/textWidgets.dart';
import 'package:dima/main.dart';
import 'package:dima/util/authentication/authentication.dart';
import 'package:dima/util/navigation/navigation_main.dart';
import 'package:dima/widgets/shopping_cart/list_of_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  final TextEditingController _passwordInputController =
      TextEditingController();

  List<Widget> listOfItems = [];

  double checkOutSum = 0;

  String? _nameValidator(String? str) {
    return str == null && str!.isEmpty ? "Your name is a required" : null;
  }

  String? _locationValidator(String? str) {
    final bool emailInvalid = str == null && str!.isEmpty;
    return emailInvalid ? "Your location is required" : null;
  }

  String? _passwordValidator(String? str) {
    return str != null && str.isNotEmpty
        ? "Please, enter a longer password"
        : null;
  }

  void _goToBankDetails() {
    SecondaryNavigator.push(context, NestedNavigatorRoutes.bankDetails);
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
    const double width = 393;
    const double height = 850;
    String username = FirebaseAuth.instance.currentUser?.displayName ?? "user";
    // getListOfItems();
    List<Widget> footer = [
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.orange[50],
          child: Divider(
            thickness: 2,
            height: 10,
            color: Colors.orange[400],
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

    setTotalPrice();
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
      setTotalPrice();
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
              validator: _nameValidator,
              decoration: const InputDecoration(hintText: "Enter your name..."),
              controller: _nameInputController,
            ),
            TextFormField(
              validator: _locationValidator,
              decoration: const InputDecoration(
                  hintText: "Enter your desired location..."),
              controller: _locationInputController,
            ),
            TextFormField(
              decoration:
                  const InputDecoration(hintText: "Enter your phone number..."),
              controller: _passwordInputController,
            ),
            TextButtonLarge(
              text: "Continue",
              onPressed: _goToBankDetails,
            ),
            TextButtonLarge(
              text: "Cancel",
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getListOfItems() async {
    List<Widget> listOfWidgets = await getItemsInCart();
    setState(() {
      listOfItems = listOfWidgets;
    });
  }

  Future<void> setTotalPrice() async {
    User? thisUser = FirebaseAuth.instance.currentUser;
    final userFavoritesRef = FirebaseDatabase.instance
        .ref()
        .child('user/' + thisUser!.uid + '/favorites');
    var listOfMapsOfMaps = await userFavoritesRef.orderByKey().once();
    Map<String, dynamic> productAsMap =
        listOfMapsOfMaps.snapshot.value as Map<String, dynamic>;
    double sum = 0;
    for (var key in productAsMap.keys) {
      Product prod =
          Product.fromRTDB(productAsMap[key] as Map<String, dynamic>);
      var priceAsString = prod.price;
      if (prod.qty > 0) {
        sum += prod.qty *
            double.parse(priceAsString.substring(0, priceAsString.length - 1));
      }
    }
    setState(() {
      checkOutSum = sum;
    });
  }
}
