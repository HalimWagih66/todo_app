import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/provider/application_provider.dart';
import 'package:todo_app/provider/task_provider.dart';
import 'package:todo_app/register%20screen/register%20screen.dart';
import 'package:todo_app/shared/style/theme/theme.dart';
import 'package:todo_app/storge%20local/cash_Helper.dart';
import 'firebase_options.dart';
import 'layout screen/home screen.dart';
import 'login/login screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  CashHelper.prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => TaskProvider(),
    child: ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: ChangeNotifierProvider(
        create: (context) => ApplicationProvider(),
          child: MyApp(),
      ),
    ),
  ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ApplicationProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName:(context)=>LoginScreen(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),
        HomeScreen.routeName:(context)=>HomeScreen(),
      },
      initialRoute: appProvider.getNameScreen(),
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // arabic
      ],
      themeMode: ThemeMode.system,
      locale: Locale(appProvider.currentLanguage),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
         bottomNavigationBarTheme: BottomNavigationBarThemeData(
           elevation: 0,
           backgroundColor: Colors.white,
           selectedItemColor: Colors.blue,
           unselectedItemColor: Colors.grey
         ),
         appBarTheme: AppBarTheme(
           elevation: 0,
           color: Colors.transparent,
          centerTitle: true,
             titleTextStyle: TextStyle(
               color: Colors.white,
               fontFamily: "Poppins",
               fontSize: 26,
               letterSpacing: 2,
               fontWeight: FontWeight.bold
             ),
      ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 23,
            fontFamily: "Poppins",
              color: Colors.blue
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
      darkTheme: ThemeApp.darkTheme
    );
  }
}
