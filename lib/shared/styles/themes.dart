import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'calibrib',
  //lon kol haga x el pernamg
  primarySwatch: defaultColor,
  //scaffold color
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    //backwardsCompatibility: true,
    //color el icons x app bar
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      //title color
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    titleSpacing: 20.0,
    //app bar color
    color: HexColor('333739'),
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      //el line ely fo2 el app bar
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);
ThemeData lightTheme= ThemeData(
  //lon kol haga x el pernamg
  primarySwatch: defaultColor,
  //scaffold color
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:  AppBarTheme(
    //color el icons x app bar
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: const TextStyle(
      //title color
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    //app bar color
    color: Colors.white,
    elevation: 0.0,
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      //el line ely fo2 el app bar
      statusBarColor: defColor,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
    elevation: 20.0,
    backgroundColor: defColor,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'calibrib',
);