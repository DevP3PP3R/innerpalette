import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final _formKey = GlobalKey<FormState>();
  // String _email = '';
  // String _password = '';

  // Future<void> _login() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     try {
  //       await _auth.signInWithEmailAndPassword(
  //           email: _email, password: _password);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Logged in as $_email')),
  //       );
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Login failed')),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Email Login')),
        body: const Scaffold(
          body: Center(child: Text('hello')),
        )

        // Form(
        //   key: _formKey,
        //   child: Column(
        //     children: <Widget>[
        //       TextFormField(
        //         decoration: const InputDecoration(labelText: 'Email'),
        //         validator: (value) =>
        //             value!.isEmpty ? 'Please enter your email' : null,
        //         onSaved: (value) => _email = value!,
        //       ),
        //       TextFormField(
        //         decoration: const InputDecoration(labelText: 'Password'),
        //         obscureText: true,
        //         validator: (value) =>
        //             value!.isEmpty ? 'Please enter your password' : null,
        //         onSaved: (value) => _password = value!,
        //       ),
        //       ElevatedButton(
        //         onPressed: _login,
        //         child: const Text('Login'),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
