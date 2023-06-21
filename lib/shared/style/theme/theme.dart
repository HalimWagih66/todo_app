import 'package:flutter/material.dart';

class ThemeApp{
  static ThemeData lightTheme = ThemeData(
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
  );
  static ThemeData darkTheme = ThemeData(
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.transparent,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedIconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
        backgroundColor: Color(0xff141922),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
            fontSize: 24,
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
            color: Colors.white
        ),
        bodySmall: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            fontFamily: "Poppins",
            color: Colors.white
        ),
      )
  );
}