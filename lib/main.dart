
import 'package:flutter/material.dart';
import 'package:todo_app/register%20screen/register%20screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterScreen.routeName:(context)=>RegisterScreen(),
      },
      initialRoute: RegisterScreen.routeName,
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
      ),
    );
  }
}
