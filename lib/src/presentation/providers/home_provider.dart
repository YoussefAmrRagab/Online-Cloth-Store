import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool chip1 = true;
  bool chip2 = false;
  bool chip3 = false;
  bool chip4 = false;
  bool chip5 = false;

  List<String> toggleChip1() {
    chip1 = !chip1;
    if (chip1 && (chip2 || chip3 || chip4 || chip5)) {
      chip1 = true;
      chip2 = false;
      chip3 = false;
      chip4 = false;
      chip5 = false;
    }
    notifyListeners();
    return _filtersText;
  }

  List<String> toggleChip2() {
    chip2 = !chip2;
    _checkIfAllItemIsSelected();
    notifyListeners();
    return _filtersText;
  }

  List<String> toggleChip3() {
    chip3 = !chip3;
    _checkIfAllItemIsSelected();
    notifyListeners();
    return _filtersText;
  }

  List<String> toggleChip4() {
    chip4 = !chip4;
    _checkIfAllItemIsSelected();
    notifyListeners();
    return _filtersText;
  }

  List<String> toggleChip5() {
    chip5 = !chip5;
    _checkIfAllItemIsSelected();
    notifyListeners();
    return _filtersText;
  }

  void _checkIfAllItemIsSelected() {
    chip1 = false;
    bool allChipIsSelected = chip2 && chip3 && chip4 && chip5;
    bool allChipNotSelected = !chip2 && !chip3 && !chip4 && !chip5;
    if (allChipIsSelected) {
      chip1 = true;
      chip2 = false;
      chip3 = false;
      chip4 = false;
      chip5 = false;
    } else if (allChipNotSelected) {
      chip1 = true;
    }
  }

  List<String> get _filtersText {
    List<String> selectedFilters = [];

    if (chip2) {
      selectedFilters.add("Smart-Casual Outfits");
    }
    if (chip3) {
      selectedFilters.add("Uni Outfits");
    }
    if (chip4) {
      selectedFilters.add("Sporty Outfits");
    }
    if (chip5) {
      selectedFilters.add("Formal Outfits");
    }

    if (selectedFilters.isEmpty) {
      selectedFilters.add("All");
    }
    return selectedFilters;
  }
}
