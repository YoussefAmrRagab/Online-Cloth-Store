import 'package:flutter/material.dart';
import '../../domain/repositories/repository.dart';

class HomeProvider extends ChangeNotifier {
  late final Repository _repository;

  HomeProvider(
    this._repository,
  );

  bool chip1 = true;
  bool chip2 = false;
  bool chip3 = false;
  bool chip4 = false;
  bool chip5 = false;

  void toggleChip1() {
    chip1 = !chip1;
    if (chip1 && (chip2 || chip3 || chip4 || chip5)) {
      chip1 = true;
      chip2 = false;
      chip3 = false;
      chip4 = false;
      chip5 = false;
    }
    notifyListeners();
  }

  void toggleChip2() {
    chip2 = !chip2;
    checkIfAllItemIsSelected();
    notifyListeners();
  }

  void toggleChip3() {
    chip3 = !chip3;
    checkIfAllItemIsSelected();
    notifyListeners();
  }

  void toggleChip4() {
    chip4 = !chip4;
    checkIfAllItemIsSelected();
    notifyListeners();
  }

  void toggleChip5() {
    chip5 = !chip5;
    checkIfAllItemIsSelected();
    notifyListeners();
  }

  void checkIfAllItemIsSelected() {
    chip1 = false;
    if (chip2 && chip3 && chip4 && chip5) {
      chip1 = true;
      chip2 = false;
      chip3 = false;
      chip4 = false;
      chip5 = false;
    }
  }
}
