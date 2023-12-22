import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../util/extensions/extensions.dart';
import '../../../domain/models/user_dto.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  Future<void> uploadUserImage(UserDTO user, File imageFile) async =>
      await _storage.ref().child(user.imageUrl).putFile(
            imageFile,
            SettableMetadata(contentType: "image/${imageFile.extension}"),
          );

  Future<String> getImageUrl(String imagePath) async =>
      await _storage.ref().child(imagePath).getDownloadURL();
}
