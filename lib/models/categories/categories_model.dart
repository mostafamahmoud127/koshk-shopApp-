class CategoriesModel {
  late bool status;
  late CategoriesDataModel data;

  CategoriesModel(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel(json['data']);
  }
}

class CategoriesDataModel {
  late int currentPage;
  late List<DataModel> data = [];

  CategoriesDataModel(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel(element));
    });
  }
}

class DataModel {
  late int id;
  late String name;
  late String image;

  DataModel(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
