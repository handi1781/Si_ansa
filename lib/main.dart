import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_ansa/home_screen/home_screen.dart';
import 'package:si_ansa/login_screen/login_screen.dart';
import 'package:si_ansa/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          print(snapshot.data);
          if (snapshot.data != null) {
            return GetMaterialApp(
              home: home_screen(),
            );
          } else {
            return GetMaterialApp(
              home: MyHomePage(),
            );
          }
        }
      },
    ),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
