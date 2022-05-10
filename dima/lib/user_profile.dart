import 'package:dima/default_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/user_page/register_form.dart';

class UserProfileRoute extends StatefulWidget {
  const UserProfileRoute(
      {Key? key,
      this.titleQuestion = 'Search for something new!',
      this.mail = ''})
      : super(key: key);
  final String titleQuestion;
  final String mail;
  @override
  State<UserProfileRoute> createState() => _UserProfileRouteState();
}

class _UserProfileRouteState extends State<UserProfileRoute> {
  void _signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DefaultScaffold()));
  }

  void _signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _mailController.text, password: _passwordController.text);
    setState(() {});
  }

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    /// TODO: why does the context.size.width return null?
    var width = 20 * 20;
    var height = 20 * 40;
    _mailController.text = widget.mail;
    User? thisUser;
    String? uid;
    if (FirebaseAuth.instance.currentUser != null) {
      //FirebaseAuth.instance.currentUser?
      thisUser = FirebaseAuth.instance.currentUser;
    }
    if (thisUser != null) {
      return Column(
        children: [
          Center(
            child: Text('Hello ' + thisUser.displayName!),
          ),
          ElevatedButton(onPressed: _signOut, child: const Text('Sign out'))
        ],
      );
    }

    return Padding(
        padding: EdgeInsets.only(
            top: height / 20, left: width / 20, right: width / 20),
        child: Column(children: [
          TextFormField(
            validator: (value) {
              final warning = value == null
                  ? 'Mail can not be empty'
                  : (value.length < 6
                      ? 'Mail needs to be of at least 6 characters'
                      : null);
              return warning;
            },
            decoration: const InputDecoration(hintText: 'Enter your mail'),
            controller: _mailController,
          ),
          TextFormField(
            validator: (value) {
              final warning = value == null
                  ? 'Password can not be empty'
                  : (value.length < 6
                      ? 'Password needs to be of at least 6 characters'
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
                  onPressed: _signIn, child: const Text('Log In'))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterForm(
                                mail: _mailController.text,
                                password: _passwordController.text)));
                  },
                  child: const Text('Register')))
        ]));
  }
}
