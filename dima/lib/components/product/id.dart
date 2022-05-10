import 'package:dima/model/product.dart';
import 'package:dima/default_scaffold.dart';
import 'package:dima/styles/styleoftext.dart';
import 'package:dima/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

/// Previously called product from id is now simply the page you get redirected when you click on a product link.
class ProductFromID extends StatefulWidget {
  const ProductFromID({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductFromID> createState() => _ProductFromIDState();
}

class _ProductFromIDState extends State<ProductFromID> {
  void _buyCallback() {
    true;
  }

  Future<void> _addToCart() async {
    User? thisUser = FirebaseAuth.instance.currentUser;
    if (thisUser == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DefaultScaffold(
                    isDefault: false,
                    givenBody: const UserProfileRoute(),
                  )));
    }
    final userFavoritesRef = FirebaseDatabase.instance.ref().child(
        'user/' + thisUser!.uid + '/favorites' + '/' + widget.product.name);
    final qt = await userFavoritesRef.child('/quantity').once();
    var quantity = 0;
    print(qt.snapshot.value);
    if (qt.snapshot.value != null) {
      quantity = qt.snapshot.value as int;
    }
    await userFavoritesRef
        .update(Product.toRTDB(widget.product, quantity: quantity));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final topPadding = MediaQuery.of(context).padding.top;

    var width = size.width;
    var height = size.height - bottomPadding - topPadding;
    Widget body =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Go Back')),
      SizedBox(
          width: width,
          height: 0.80 * height,
          child: ListView(
            children: [
              widget.product.image,
              Text(
                widget.product.name,
                style: const TextStyle(
                    color: headerTextColor, fontSize: productTitleSize),
              ),
              const Text(
                  "Description -- Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum")
            ],
          )),
      Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.product.price,
            style: const TextStyle(fontSize: 17),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: ElevatedButton(
                onPressed: _addToCart,
                child: const Icon(Icons.add_shopping_cart_rounded)),
          ),
          ElevatedButton(
              onPressed: _buyCallback, child: const Text('Buy this product'))
        ],
      )
    ]);
    return DefaultScaffold(givenBody: body, isDefault: false);
  }
}
