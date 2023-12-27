import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class Failure {
  final Object message;

  Failure(this.message);
}

class ErrorHandler extends Failure {
  ErrorHandler(super.message);

  late Failure failure;

  ErrorHandler.handle(super.message) {
    debugPrint('ErrorHandler: $message');
    if (message is FirebaseAuthException) {
      debugPrint(
        'auth exception code : ${(message as FirebaseAuthException).code} ${(message as FirebaseAuthException).message}',
      );
      switch ((message as FirebaseAuthException).code) {
        case 'email-already-in-use':
          failure = ErrorHandler(
              'The email address is already in use by another account.');
        case 'invalid-email':
          failure = ErrorHandler('The email address is not valid.');
        case 'weak-password':
          failure = ErrorHandler('The password is too weak.');
        case 'requires-recent-login':
          failure = ErrorHandler(
              'This operation is sensitive and requires recent authentication. Log in again before retrying this request.');
        case 'operation-not-allowed':
          failure = ErrorHandler(
              'This operation is not allowed right now. Try again later');
        case 'network-request-failed':
          failure = ErrorHandler('No Internet Connection');
        case 'INVALID_LOGIN_CREDENTIALS':
        case 'invalid-credential':
          failure = ErrorHandler(
              "The data you provided is incorrect. Please make sure you've entered the right information and try again. ");
        case 'too-many-requests':
          failure = ErrorHandler(
              "We have blocked all requests from this device due to unusual activity. Try again later.");
        default:
          failure = ErrorHandler('An error occurred, please try again.');
      }
    } else if (message is int) {
      switch (message as int) {
        case 404:
          failure =
              ErrorHandler('Your request was not found, please try later');
        case 500:
          failure =
              ErrorHandler('There is a temporary problem, please try later');
        case >= 400:
          failure =
              ErrorHandler('Unknown server error with status code: $message');
        default:
      }
    } else if (message is String) {
      if (message == "notVerifiedException") {
        failure = ErrorHandler(
          'This email is not Verified, you have to verify your email',
        );
        return;
      }
      try {
        failure = ErrorHandler(jsonDecode(message as String)['error']);
      } catch (e) {
        failure = ErrorHandler(message);
      }
    } else {
      failure = ErrorHandler('Oops there was an error, please try again');
    }
  }
}
