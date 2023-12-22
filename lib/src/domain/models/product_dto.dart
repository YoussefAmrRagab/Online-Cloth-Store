class ProductDTO {
  String category;
  String description;
  String gender;
  int id;
  String name;
  double price;
  double rating;
  String brand;
  List<String> sizes;
  late String imageUrl;

  String get imagePath => 'products/$id.png';

  ProductDTO({
    required this.category,
    required this.description,
    required this.gender,
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.brand,
    required this.sizes,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) => ProductDTO(
      category: json["Category"],
      description: json["Description"],
      gender: json["Gender"],
      id: json["ID"],
      name: json["Name"],
      price: json["Price"],
      rating: json["Rating"],
      brand: json["Brand"],
      sizes: List.from(json["Sizes"]));
}
