import 'firebase_service.dart';
import 'storage_service.dart';
import 'auth_service.dart';

class RemoteServices {
  AuthService authService;
  FirebaseService firebaseService;
  StorageService storageService;

  RemoteServices(
    this.authService,
    this.firebaseService,
    this.storageService,
  );
}
