import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/controller/bloc/cubits/shopCubit.dart';
import 'package:shop_app/controller/cashing/HiveKeys.dart';
import 'package:shop_app/view/screens/SerachScreen.dart';
import 'package:shop_app/view/screens/ShopLayout.dart';
import 'package:shop_app/view/screens/LoginScreen.dart';
import 'package:shop_app/view/screens/OnBoardingScreen.dart';

import 'controller/bloc/observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await Hive.initFlutter();
  await Hive.openBox('data');
  //await Hive.box('data').clear();
  Widget widget;
  bool isOnBoarding = Hive.box('data').get(HiveKeys.isOnBoarding) ?? true;
  bool isLogged = Hive.box('data').get(HiveKeys.token) != null;
  widget = isOnBoarding
      ? OnBoardingScreen()
      : (!isLogged ? LoginScreen() : ShopLayout());
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;

  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites(),
          ),
        ],
        child: MaterialApp(
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
          home: widget,
          routes: {
            LoginScreen.routeName: (_) => LoginScreen(),
            ShopLayout.routeName: (_) => ShopLayout(),
            SearchScreen.routeName: (_) => SearchScreen(),
          },
        ));
  }
}
