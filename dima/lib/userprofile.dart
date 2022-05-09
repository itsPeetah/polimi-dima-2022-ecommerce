import 'package:dima/components/userPage/register_form.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserProfileRoute extends StatelessWidget {
  UserProfileRoute(
      {Key? key,
      this.titleQuestion = 'Search for something new!',
      this.username = ''})
      : super(key: key);
  final String titleQuestion;
  final String username;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    /// TODO: why does the context.size.width return null?
    var width = 20 * 20;
    var height = 20 * 40;
    _usernameController.text = username;
    return Padding(
        padding: EdgeInsets.only(
            top: height / 20, left: width / 20, right: width / 20),
        child: Column(children: [
          TextFormField(
            validator: (value) {
              value == null
                  ? 'Username can not be empty'
                  : (value.length < 6
                      ? 'Username needs to be of at least 6 characters'
                      : null);
            },
            decoration: const InputDecoration(hintText: 'Enter your username'),
            controller: _usernameController,
          ),
          TextFormField(
            validator: (value) {
              value == null
                  ? 'Password can not be empty'
                  : (value.length < 6
                      ? 'Password needs to be of at least 6 characters'
                      : null);
            },
            decoration: const InputDecoration(hintText: 'Enter your password'),
            controller: _passwordController,
            obscureText: true,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                  onPressed: () {}, child: const Text('Log In'))),
          Padding(

              /// TODO: Add log in and shopping cart
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterForm(
                                username: _usernameController.text,
                                password: _passwordController.text)));
                  },
                  child: const Text('Register')))
        ]));
  }
}
