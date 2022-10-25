import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/view/screens/LoginScreen.dart';
import 'package:shop_app/view/screens/OnBoardingScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Color(0xff204254),
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xff204254)),
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      home: OnBoardingScreen(),

      routes: {
        LoginScreen.routeName: (_) =>  LoginScreen(),
      },
    );
  }
}
