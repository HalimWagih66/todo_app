import 'package:flutter/material.dart';
import 'package:todo_app/register%20screen/register%20screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RegisterScreen.routeName:(context)=>RegisterScreen(),
      },
      initialRoute: RegisterScreen.routeName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
