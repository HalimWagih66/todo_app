import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider_application.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ProviderApplication>(context);
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(
            context,
            appProvider.getNameScreen());
      },
    );
    return Container(
      child: Image(
        image: AssetImage(appProvider.getSplashScree()),
      ),
    );
  }
}
