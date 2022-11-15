import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/services/api.dart';
import 'package:shop_app/view/screens/CategoriesScreen.dart';
import 'package:shop_app/view/screens/FavouritesScreen.dart';
import 'package:shop_app/view/screens/ProductsScreen.dart';
import 'package:shop_app/view/screens/SetttingsScreen.dart';

import '../../../model/HomeModel.dart';
import '../states/shopStates.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void navigateToScreen(int index) {
    currentIndex = index;
    emit(ShopNavigateScreenState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeData());

    Api().api.get('home').then((value) {
      print(value.data);
      homeModel = HomeModel.fromJson(value.data);
      emit(ShopSuccessHomeData());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(ShopErrorHomeData());
    });
  }
}
