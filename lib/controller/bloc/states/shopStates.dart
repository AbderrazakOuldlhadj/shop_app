import 'package:shop_app/model/ChangeFavoriteModel.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopNavigateScreenState extends ShopStates {}

class ShopLoadingHomeData extends ShopStates {}

class ShopSuccessHomeData extends ShopStates {}

class ShopErrorHomeData extends ShopStates {}

class ShopSuccessCategoriesData extends ShopStates {}

class ShopErrorCategoriesData extends ShopStates {}

class ShopChangeFavorite extends ShopStates {}

class ShopSuccessChangeFavorite extends ShopStates {
  final ChangeFavoriteModel model;

  ShopSuccessChangeFavorite(this.model);
}

class ShopErrorChangeFavorite extends ShopStates {}

class ShopLoadingGetFavorites extends ShopStates {}

class ShopSuccessGetFavorites extends ShopStates {}

class ShopErrorGetFavorites extends ShopStates {}
