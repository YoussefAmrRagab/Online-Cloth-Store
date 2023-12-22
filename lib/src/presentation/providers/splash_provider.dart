import 'package:flutter/material.dart';
import '../../util/extensions/extensions.dart';
import '../../config/router/routes_name.dart';
import '../../domain/models/product_dto.dart';
import '../../domain/models/user_dto.dart';
import '../../domain/repositories/repository.dart';

class SplashProvider extends ChangeNotifier {
  late final Repository _repository;

  SplashProvider(
    this._repository,
  );

  List<ProductDTO> products = [];
  late UserDTO user;

  Future<String> fetchData() async {
    final userResponse = await _repository.getUser();
    if (userResponse is! UserDTO) {
      (userResponse as String).showToast;
      return RoutesName.loginRoute;
    }
    user = userResponse;

    final products = await _repository.getProducts();
    if (products is! List<ProductDTO>) {
      (products as String).showToast;
    }
    this.products = products;

    return RoutesName.mainRoute;
  }
}
