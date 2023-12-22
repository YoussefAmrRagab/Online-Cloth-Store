import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../failure.dart';

typedef FutureEither<T> = Future<Either<String?, T>>;

typedef FailureEither<T> = Either<Failure, T>;

extension Space on num {
  SizedBox get marginHeight => SizedBox(height: toDouble());

  SizedBox get marginWidth => SizedBox(width: toDouble());
}

extension ScreenSize on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;

  double get screenWidth => MediaQuery.sizeOf(this).width;
}

extension StringExtensions on String {
  bool get isValidPassword {
    RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#^_]).{8,}$',
    );
    return passwordRegex.hasMatch(this);
  }

  bool get isValidEmail {
    // Regular expression for a basic email validation
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegex.hasMatch(this);
  }

  void get showToast => Fluttertoast.showToast(msg: this);
}

extension FileDetails on File {
  String get extension => path.split('.').last;

  String get directory => path.substring(0, path.lastIndexOf('/'));
}

extension PasswordIcon on bool {
  IconData get passwordIcon =>
      this ? Icons.visibility_outlined : Icons.visibility_off_outlined;
}
