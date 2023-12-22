import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../data/data_sources/remote/remote_services.dart';
import '../../util/extensions/extensions.dart';
import '../../util/failure.dart';
import '../../util/resources/strings.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/models/user_dto.dart';

class AuthRepositoryImpl implements AuthRepository {
  late final RemoteServices _remoteServices;

  AuthRepositoryImpl(this._remoteServices);

  @override
  Future<String> login(String email, String password) async {
    FailureEither<void> response = await executeAndHandleError<void>(() async {
      return await _remoteServices.authService.authUser(email, password);
    });
    return response.fold(
      (failure) => failure.message.toString(),
      (_) => StringManager.success,
    );
  }

  @override
  Future<String> registerUser(
    String name,
    String email,
    String password,
    String birthday,
    int weight,
    int height,
    String gender,
    String? imagePath,
  ) async {
    FailureEither<void> response = await executeAndHandleError(() async {
      return await _remoteServices.authService.createUser(email, password);
    });

    return response.fold((failure) => failure.message.toString(), (_) async {
      UserDTO user = UserDTO(
        id: _remoteServices.authService.userId,
        name: name,
        email: email,
        birthday: birthday,
        weight: weight,
        height: height,
        gender: gender,
        imageUrl: imagePath ?? "",
      );
      return _uploadUserDataToDatabase(user, imagePath);
    });
  }

  Future<String> _uploadUserDataToDatabase(
    UserDTO user,
    String? userImagePath,
  ) async {
    FailureEither<void> res = await executeAndHandleError(() async {
      return await _remoteServices.firebaseService.uploadUserData(user);
    });
    return res.fold((failure) => failure.message.toString(), (_) async {
      if (userImagePath != null) {
        FailureEither<void> responseImage =
            await executeAndHandleError(() async {
          await _remoteServices.storageService
              .uploadUserImage(user, File(userImagePath));
        });
        return responseImage.fold(
          (failure) => failure.message.toString(),
          (_) => StringManager.success,
        );
      }
      return StringManager.success;
    });
  }

  @override
  Future<String> sendResetPasswordEmail(String email) async {
    FailureEither<void> response = await executeAndHandleError(() async {
      return await _remoteServices.authService.resetPassword(email);
    });

    return response.fold(
      (failure) => failure.message.toString(),
      (_) => StringManager.resetPasswordMessage,
    );
  }

  Future<Either<Failure, T>> executeAndHandleError<T>(
    Future<T> Function() function,
  ) async {
    try {
      final result = await function();
      return right(result);
    } catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      debugPrint("error message: ${failure.message}");
      return left(failure);
    }
  }
}
