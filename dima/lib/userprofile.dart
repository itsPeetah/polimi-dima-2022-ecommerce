import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserProfileRoute extends StatelessWidget {
  UserProfileRoute({Key? key, this.titleQuestion = 'Search for something new!'})
      : super(key: key);
  final String titleQuestion;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final List<TextEditingController> controllers = [];
  final userRef = FirebaseDatabase.instance.ref().child('/user');
  late BuildContext context;
  void _userNameError() {}
  Future<void> _registerUser() async {
    if (_nameController.text.isNotEmpty) {
      if (_surnameController.text.isNotEmpty) {
        if (_passwordController.text.isNotEmpty) {
          if (_emailController.text.isNotEmpty) {
            var query = userRef.orderByKey().equalTo(_usernameController.text);
            var queryResult = await query.once();
            // user does not already exist
            if (queryResult.snapshot.value == null) {
              userRef.child(_usernameController.text).set({
                'name': _nameController.text,
                'surname': _surnameController.text,
                'email': _emailController.text,
                'password': _passwordController.text
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registered successfully')),
              );
              for (var controller in controllers) {
                controller.clear();
              }
            } else {
              _userNameError();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User already exists')),
              );
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    controllers.add(_nameController);
    controllers.add(_surnameController);
    controllers.add(_passwordController);
    controllers.add(_emailController);
    controllers.add(_usernameController);
    return Column(children: [
      TextFormField(
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
        decoration: const InputDecoration(hintText: 'Enter your password'),
        controller: _passwordController,
        obscureText: true,
      ),
      TextFormField(
        decoration: const InputDecoration(hintText: 'Enter your email'),
        controller: _emailController,
      ),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
              onPressed: _registerUser, child: const Text('Submit')))
    ]);

    // Center(
    //   child: ElevatedButton(
    //     onPressed: () {
    //       // set in child with id 000000001 all user details
    //       userRef.child('000000001').set({
    //         'name': 'Bruhero',
    //         'surname': 'Montero',
    //         'email': 'bruheromontero@gmail.com',
    //         'password': 'xH3S7Tuvd5Eo2xkEjz'
    //       });
    //       true;
    //       //Navigator.pop(context);
    //     },
    //     child: const Text('Register'),
    //   ),
    // );
  }
}
