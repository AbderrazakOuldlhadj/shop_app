/*  */

class HomeModel {
  bool status;
  HomeDataModel data;

  HomeModel({required this.status, required this.data});

  factory HomeModel.fromJson(Map json) {
    return HomeModel(
      status: json['status'],
      data: HomeDataModel.fromJson(json['data']),
    );
  }
}

class HomeDataModel {
  List<BannerModel> banners;
  List<ProductModel> products;

  HomeDataModel({required this.banners, required this.products});

  factory HomeDataModel.fromJson(Map json) {
    return HomeDataModel(
      banners: (json['banners'] as List)
          .map((banner) => BannerModel.fromJson(banner))
          .toList(),
      products: (json['products'] as List)
          .map((banner) => ProductModel.fromJson(banner))
          .toList(),
    );
  }
}

class BannerModel {
  int id;
  String image;
  BannerModel({required this.id, required this.image});

  factory BannerModel.fromJson(Map json) {
    return BannerModel(
      id: json['id'],
      image: json['image'],
    );
  }
}

class ProductModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavorites;
  bool inCart;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.inFavorites,
    required this.inCart,
  });

  factory ProductModel.fromJson(Map json) {
    return ProductModel(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      inFavorites: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }
}
