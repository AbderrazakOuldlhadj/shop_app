import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/controller/bloc/cubits/shopCubit.dart';
import 'package:shop_app/controller/bloc/states/shopStates.dart';
import 'package:shop_app/controller/cashing/HiveKeys.dart';
import 'package:shop_app/view/components.dart';
import 'package:shop_app/view/screens/LoginScreen.dart';

import 'SerachScreen.dart';

class ShopLayout extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        ShopCubit cubit = ShopCubit.get(ctx);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Hanuuty"),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(SearchScreen.routeName);
                },
                child: const Icon(
                  Icons.search,
                  size: 35,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) async {
              /* if (index == 2) {
                await cubit.getFavorites();
              } */
              cubit.navigateToScreen(index);
            },
            items: const [
              BottomNavigationBarItem(
                backgroundColor: primaryColor,
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Categories",
                icon: Icon(Icons.apps),
              ),
              BottomNavigationBarItem(
                label: "Favorites",
                icon: Icon(Icons.favorite),
              ),
              BottomNavigationBarItem(
                label: "Settings",
                icon: Icon(Icons.settings),
              ),
            ],
          ),
        );
      },
    );
  }
}
