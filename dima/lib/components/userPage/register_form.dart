import 'package:dima/default_scaffold.dart';
import 'package:dima/userprofile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm(
      {Key? key,
      this.titleQuestion = 'Search for something new!',
      this.username = '',
      this.password = ''})
      : super(key: key);
  final String titleQuestion;
  var username = '';
  var password = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final List<TextEditingController> controllers = [];
  final userRef = FirebaseDatabase.instance.ref().child('/user');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late BuildContext context;
  void _userNameError() {}
  _registerUser() async {
    final FormState? form = _formKey.currentState;
    form!.validate();
    bool correctData = true;
    if (_nameController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _emailController.text.isEmpty) {
      correctData = false;
    }
    if (!correctData) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all required information.')),
      );
      return;
    }
    var queryResult =
        await userRef.orderByKey().equalTo(_usernameController.text).once();

    /// TODO: figure why there is an error here
    if (queryResult.snapshot.value != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('User with that username already exists.')),
      );
      return;
    }
    // user does not already exist
    await userRef.child(_usernameController.text).set({
      'name': _nameController.text,
      'surname': _surnameController.text,
      'email': _emailController.text,
      'password': _passwordController.text
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registered successfully')),
    );
    dynamic usedUsername = _usernameController.text;
    for (var controller in controllers) {
      controller.clear();
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DefaultScaffold(
                isDefault: false,
                givenBody: UserProfileRoute(
                  username: usedUsername,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    controllers.add(_nameController);
    controllers.add(_surnameController);
    controllers.add(_passwordController);
    controllers.add(_emailController);
    controllers.add(_usernameController);
    _usernameController.text = username;
    _passwordController.text = password;
    dynamic body = Form(
        key: _formKey,
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
            decoration: const InputDecoration(hintText: 'Enter your name'),
            controller: _nameController,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Enter your surname'),
            controller: _surnameController,
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
          TextFormField(
            validator: (value) {
              value == null
                  ? 'Email can not be empty'
                  : (value.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                      ? 'Please input a correct email'
                      : null);
            },
            decoration: const InputDecoration(hintText: 'Enter your email'),
            controller: _emailController,
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
