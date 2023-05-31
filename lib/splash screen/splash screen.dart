import 'package:flutter/material.dart';
import 'package:todo_app/register%20screen/register%20screen.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "SplashScreen";
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),(){Navigator.pushReplacementNamed(context, RegisterScreen.routeName);},);
    return Container(
      child: Image(
        image: AssetImage("assets/images/splash screen/light/splash_light.png"),
      ),
    );
  }
}
