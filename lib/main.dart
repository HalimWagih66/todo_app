
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/register%20screen/register%20screen.dart';

import 'firebase_options.dart';
import 'login/login screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName:(context)=>LoginScreen(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),
      },
      initialRoute: LoginScreen.routeName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
         appBarTheme: AppBarTheme(
           elevation: 0,
           color: Colors.transparent,
          centerTitle: true,
             titleTextStyle: TextStyle(
               color: Colors.white,
               fontFamily: "Poppins",
               fontSize: 20,
               fontWeight: FontWeight.bold
             ),
      ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 23,
            fontFamily: "Poppins",
            color: Colors.black
          )
        )
      ),
    );
  }
}
