import 'package:flutter/material.dart';
import '../../domain/repositories/repository.dart';

class HomeProvider extends ChangeNotifier {
  late final Repository _repository;

  HomeProvider(
    this._repository,
  );

  bool chip1 = false;
  bool chip2 = false;
  bool chip3 = false;
  bool chip4 = false;
  bool chip5 = false;

  void toggleChip1() {
    chip1 = !chip1;
    notifyListeners();
  }

  void toggleChip2() {
    chip2 = !chip2;
    notifyListeners();
  }

  void toggleChip3() {
    chip3 = !chip3;
    notifyListeners();
  }

  void toggleChip4() {
    chip4 = !chip4;
    notifyListeners();
  }

  void toggleChip5() {
    chip5 = !chip5;
    notifyListeners();
  }
}
