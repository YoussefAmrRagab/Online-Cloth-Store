class UserDTO {
  late String id, name, email, birthday, imageUrl, gender;
  late int weight, height, age;

  UserDTO({
    this.id = "",
    required this.name,
    required this.email,
    required this.birthday,
    required this.weight,
    required this.height,
    required this.gender,
    required this.imageUrl,
  }) {
    if (imageUrl != "") {
      imageUrl = "users/$id";
    }

    age = DateTime.now().year - int.parse(birthday.split('-').last);
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
      'imageUrl': imageUrl
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
    );
  }
}
