import 'package:dima/components/model/fire_auth.dart';
import 'package:dima/default_scaffold.dart';
import 'package:dima/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm(
      {Key? key,
      this.titleQuestion = 'Search for something new!',
      this.mail = '',
      this.password = ''})
      : super(key: key);
  final String titleQuestion;
  var mail = '';
  var password = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<TextEditingController> controllers = [];
  final userRef = FirebaseDatabase.instance.ref().child('/user');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late BuildContext context;
  void _userNameError() {
    ///TODO: why does the validator not highlight text
  }
  _registerUser() async {
    final FormState? form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }
    // print('Controlling mail');
    // var queryResult =
    //     await userRef.orderByKey().equalTo(_emailController.text).once();
    // print('Controlled mail');

    /// TODO: figure why there is an error here
    // if (queryResult.snapshot.value != null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //         content: Text('User with that username already exists.')),
    //   );
    //   return;
    // }

    print('Calling register: ');
    User? user;
    try {
      user = await FireAuth.registerUsingEmailPassword(
          name: _nameController.text + ' ' + _surnameController.text,
          email: _emailController.text,
          password: _passwordController.text);
      print('Result of register: ');
    } on Exception catch (exception) {
      print('Error while trying to create a user');
      print(exception);
      return;
    }
    print(user!.uid);

    // user does not already exist
    try {
      await userRef.child(user.uid).set({
        'name': _nameController.text,
        'surname': _surnameController.text,
        'email': _emailController.text,

        /// TODO: remove?
        'password': _passwordController.text,
        'favorites': '',
        'bought': '',
        'visualized': ''
      });
    } on Exception catch (exception, stackTrace) {}
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registered successfully')),
    );
    dynamic usedMail = _emailController.text;
    for (var controller in controllers) {
      controller.clear();
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DefaultScaffold(
                isDefault: false,
                givenBody: UserProfileRoute(
                  mail: usedMail,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    controllers.add(_nameController);
    controllers.add(_surnameController);
    controllers.add(_passwordController);
    controllers.add(_emailController);
    _emailController.text = mail;
    _passwordController.text = password;
    dynamic body = Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            validator: (value) {
              final warning = value == null
                  ? 'Email can not be empty'
                  : (!value.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                      ? 'Please input a correct email'
                      : null);
              return warning;
            },
            decoration: const InputDecoration(hintText: 'Enter your email'),
            controller: _emailController,
          ),
          TextFormField(
            validator: (value) {
              final warning = (value == null || value.isEmpty)
                  ? 'Your name can not be empty.'
                  : null;
              return warning;
            },
            decoration: const InputDecoration(hintText: 'Enter your name'),
            controller: _nameController,
          ),
          TextFormField(
            validator: (value) {
              final warning = (value == null || value.isEmpty)
                  ? 'Your surname can not be empty.'
                  : null;
              return warning;
            },
            decoration: const InputDecoration(hintText: 'Enter your surname'),
            controller: _surnameController,
          ),
          TextFormField(
            validator: (value) {
              final warning = (value == null || value.isEmpty)
                  ? 'Password can not be empty.'
                  : (value.length < 6
                      ? 'Password needs to be at least 6 characters long.'
                      : null);
              return warning;
            },
            decoration: const InputDecoration(hintText: 'Enter your password'),
            controller: _passwordController,
            obscureText: true,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                  onPressed: _registerUser, child: const Text('Submit')))
        ]));
    body = Padding(
        child: body,
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20));
    return DefaultScaffold(isDefault: false, givenBody: body);
  }
}
