import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../util/resources/strings.dart';
import '../../../domain/models/user_dto.dart';

class FirebaseService {
  final _database = FirebaseFirestore.instance;
  final _realtime = FirebaseDatabase.instance;

  Future<void> uploadUserData(UserDTO user) async => await _database
      .collection(StringManager.usersCollection)
      .doc(user.id)
      .set(user.toJson());

  Future<UserDTO> getUserData(String userId) async {
    final res = await _database
        .collection(StringManager.usersCollection)
        .doc(userId)
        .get();

    if (res.data() != null) {
      Map<String, dynamic> data = res.data()!;
      data['id'] = userId;
      return UserDTO.fromJson(data);
    } else {
      throw 'user not found in database, it may be deleted or not registered';
    }
  }

  Future<List> getProducts() async {
    DataSnapshot snapshot = await _realtime.ref().child("Products").get();
    Object response = snapshot.value ?? [];
    return response as List;
  }

  Future<void> updateUserFavourites(
    String userId,
    List<Map<String, dynamic>> userFavourites,
  ) async =>
      await _database
          .collection(StringManager.usersCollection)
          .doc(userId)
          .update({'favourites': userFavourites});
}
