import 'dart:js';

import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key, this.reason = "Invalid route"})
      : super(key: key);

  final String reason;

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "404",
            style: TextStyle(fontSize: 44),
          ),
          Text(
            reason,
            style: TextStyle(fontSize: 28),
          ),
          Container(
            child: _backButton(context),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget? _backButton(BuildContext context) {
    bool canGoBack = Navigator.of(context).canPop();
    return canGoBack
        ? TextButton(
            onPressed: () => _goBack(context),
            child: const Text("Go back", style: TextStyle(fontSize: 28)),
          )
        : null;
  }
}
