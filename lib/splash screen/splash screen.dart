import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/register%20screen/register%20screen.dart';

import '../provider/provider_application.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "SplashScreen";
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ProviderApplication>(context);
    Future.delayed(Duration(seconds: 3),(){Navigator.pushReplacementNamed(context, RegisterScreen.routeName);},);
    return Container(
      child: Image(
        image: AssetImage(appProvider.getSplashScree()),
      ),
    );
  }
}
