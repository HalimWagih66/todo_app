
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/register%20screen/register%20screen.dart';
import 'package:todo_app/splash%20screen/splash%20screen.dart';
import 'firebase_options.dart';
import 'layout screen/home screen.dart';
import 'login/login screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => AuthProvider(),
      child: MyApp()
  ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName:(context)=>LoginScreen(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),
        HomeScreen.routeName:(context)=>HomeScreen(),
        SplashScreen.routeName:(context)=>SplashScreen(),
      },
      initialRoute: SplashScreen.routeName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
         bottomNavigationBarTheme: BottomNavigationBarThemeData(
           elevation: 0,
           backgroundColor: Colors.transparent
         ),
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
          ),
          bodyMedium: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              fontFamily: "Poppins",
              color: Colors.black
          ),
          bodySmall: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              fontFamily: "Poppins",
              color: Colors.black
          ),
        )
      ),

    );
  }
}
