import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/services/api.dart';
import 'package:shop_app/model/CategoriesModel.dart';
import 'package:shop_app/model/ChangeFavoriteModel.dart';
import 'package:shop_app/model/FavoritesModel.dart';
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

  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeData());

    Api().api.get('home').then((value) {
      print(value.data);
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach(
        (element) => favourites.addAll({element.id: element.inFavorites}),
      );
      print(favourites);
      emit(ShopSuccessHomeData());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeData());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    Api().api.get('categories').then((value) {
      print("Categories");
      print(value.data);
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesData());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesData());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorite(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavorite());

    Api().api.post('favorites', data: {'product_id': productId}).then((value) {
      print(value.data);
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);

      if (!changeFavoriteModel!.status) {
        favourites[productId] = !favourites[productId]!;
        emit(ShopChangeFavorite());
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavorite(changeFavoriteModel!));
    }).catchError((error) {
      print(error.toString());

      favourites[productId] = !favourites[productId]!;
      emit(ShopErrorChangeFavorite());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavorites());
    Api().api.get('favorites').then((value) {
      print(value.data);

      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavorites());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavorites());
    });
  }
}
