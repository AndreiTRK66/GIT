

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
 import 'package:flutter/material.dart';

import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState(){
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children:[
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Enter your email",
            ),
          ),
          TextField(
            controller: _password,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              hintText:"Enter your password",
            ),
          ),
          TextButton(
            onPressed: () async {
              await Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              );

              final email = _email.text;
              final password = _password.text;
              try{
                final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password);
                print(userCredential);
              } on FirebaseAuthException catch(e) {
                //print('Asta e eroarea');
                //print(e.code);
                if(e.code == 'user-not-found'){
                  print('User not found');
                } else if(e.code == 'Wrong-Passowrd'){
                  print('Wrong password');
                } else{
                  print('Alta Eroare');
                  print(e.code);
                }

              }
            },
            child: const Text('Login'),
          ),
            TextButton(
                onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/register/',
                      (route) => false,
                  );
                } ,
                child: const Text('Not registered yet? Register here!'),
            )
        ],
      ),
    );
  }
}
