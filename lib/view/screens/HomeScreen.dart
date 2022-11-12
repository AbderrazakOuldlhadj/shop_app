import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/controller/cashing/HiveKeys.dart';
import 'package:shop_app/view/screens/LoginScreen.dart';

class HomeScreen extends StatelessWidget {

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text("Sign Out"),
          onPressed: () async {
                Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                await Hive.box('data').delete(HiveKeys.token);
          },
        ),
      ),
    );
  }
}
