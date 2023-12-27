import 'product_dto.dart';

class UserDTO {
  String id, name, email, birthday, imageUrl, gender;
  int weight, height;
  List<ProductDTO> favourites;
  late int age;

  UserDTO({
    this.id = "",
    required this.name,
    required this.email,
    required this.birthday,
    required this.weight,
    required this.height,
    required this.gender,
    required this.imageUrl,
    required this.favourites,
  }) {
    if (imageUrl != "") {
      imageUrl = "users/$id";
    }

    age = DateTime.now().year - int.parse(birthday.split('-').last);
  }

  void addToFavourite(ProductDTO product) {
    favourites.add(product);
    product.isFavourite = true;
  }

  void deleteFromFavourite(ProductDTO product) {
    favourites.removeWhere((element) => element.id == product.id);
    product.isFavourite = false;
  }

  List<Map<String, dynamic>> get favouriteAsMap {
    List<Map<String, dynamic>> favouritesMap = [];
    for (var product in favourites) {
      favouritesMap.add(product.toJson());
    }
    return favouritesMap;
  }

  // Convert the object to a map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'birthday': birthday,
      'weight': weight,
      'height': height,
      'gender': gender,
      'imageUrl': imageUrl,
      'favourites': favouriteAsMap
    };
  }

  // Create a User object from a map
  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      birthday: json['birthday'],
      weight: json['weight'],
      height: json['height'],
      gender: json['gender'],
      imageUrl: json['imageUrl'],
      favourites: List.from(json['favourites'])
          .map((element) => ProductDTO.fromJson(element))
          .toList(),
    );
  }
}
