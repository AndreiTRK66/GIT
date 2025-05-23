import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:primaaplicatie/views/login_view.dart';
import 'package:primaaplicatie/views/register_view.dart';
import 'package:primaaplicatie/views/verify_email_view.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 

  runApp(MaterialApp(
    title: 'Flutter Demo',

    theme: ThemeData(

      primarySwatch: Colors.green,
    ),
    home: const HomePage(),
    routes: {
      '/login/':(context) => const LoginView(),
      '/register/':(context) => const RegisterView(),
    }
    ),
  );
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if(user != null){
                if(user.emailVerified){
                  print('Email is verified');
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
              return const Text('Done');
            // if(user?.emailVerified ?? false){
            //   return const Text('Done');
            // } else {
            //   return const VerifyEmailView();
            // }
              return const LoginView();
            default:
              return const CircularProgressIndicator();
          }

        }
    );
  }
}



