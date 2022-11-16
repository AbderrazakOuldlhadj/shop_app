class CategoriesModel {
  bool status;
  CategoriesDataModel data;

  CategoriesModel({required this.status, required this.data});
  factory CategoriesModel.fromJson(Map json) {
    return CategoriesModel(
      status: json['status'],
      data: CategoriesDataModel.fromJson(json['data']),
    );
  }
}

class CategoriesDataModel {
  int currentPage;
  List<DataModel> data;
  CategoriesDataModel({required this.currentPage, required this.data});
  factory CategoriesDataModel.fromJson(Map json) {
    return CategoriesDataModel(
      currentPage: json['current_page'],
      data: (json['data'] as List)
          .map((dataModel) => DataModel.fromJson(dataModel))
          .toList(),
    );
  }
}

class DataModel {
  int id;
  String name;
  String image;

  DataModel({required this.id, required this.name, required this.image});

  factory DataModel.fromJson(Map json) {
    return DataModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
