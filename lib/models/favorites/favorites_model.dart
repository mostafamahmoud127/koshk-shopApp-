class FavoritesModel {
  late bool? status;
  late String? message;
  late Data data;

  FavoritesModel(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data(json['data']) : null)!;
  }
}

class Data {
  late int? currentPage;
  late List<FavoritesData> data;
  late String? firstPageUrl;
  late int? from;
  late int? lastPage;
  late String? lastPageUrl;
  late String? nextPageUrl;
  late String? path;
  late int? perPage;
  late String? prevPageUrl;
  late int? to;
  late int? total;

  Data(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != []) {
      data = <FavoritesData>[];
      json['data'].forEach((v) {
        data.add(FavoritesData(v));
      });
    } else {
      data = json['data'];
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FavoritesData {
  late int id;
  late Product product;

  FavoritesData(Map<String, dynamic> json) {
    id = json['id'];
    product = (json['product'] != null ? Product(json['product']) : null)!;
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  Product(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
