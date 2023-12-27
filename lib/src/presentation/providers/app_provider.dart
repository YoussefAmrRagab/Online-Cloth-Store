import 'package:flutter/material.dart';
import '../../util/extensions/extensions.dart';
import '../../config/router/routes_name.dart';
import '../../domain/models/product_dto.dart';
import '../../domain/models/user_dto.dart';
import '../../domain/repositories/repository.dart';

class AppProvider extends ChangeNotifier {
  late final Repository _repository;

  AppProvider(
    this._repository,
  );

  List<ProductDTO> products = [];
  late UserDTO user;

  Future<String> fetchData() async {
    final userResponse = await _repository.getUser();
    if (userResponse is! UserDTO) {
      if (userResponse != null) {
        (userResponse as String).showToast;
      }
      return RoutesName.loginRoute;
    }
    user = userResponse;

    final products = await _repository.getProducts();
    if (products is! List<ProductDTO>) {
      (products as String).showToast;
    }
    this.products = products;

    for (var e in user.favourites) {
      int index = this.products.indexWhere((element) => element.id == e.id);
      if (index > -1) {
        this.products[index].isFavourite = true;
      }
    }

    return RoutesName.mainRoute;
  }

  void onFavouriteClick(ProductDTO product) {
    product.isFavourite
        ? user.deleteFromFavourite(product)
        : user.addToFavourite(product);
    _repository.updateUserFavourites(user.favouriteAsMap);
    notifyListeners();
  }
}
