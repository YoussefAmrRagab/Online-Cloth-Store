import '../models/user_dto.dart';

abstract class Repository {
  Future<dynamic> getProducts();

  Future<dynamic> getUser();

  Future<String> updateUserData(UserDTO user);

  Future<void> updateUserFavourites(
    List<Map<String, dynamic>> userFavouritesList,
  );
}
