import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../util/constants/constants.dart';
import '../../util/resources/colors.dart';
import '../../util/resources/dimens.dart';
import '../providers/app_provider.dart';
import '../widgets/product_card.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: const Center(child: Text("Coming Soon")));
  }
}

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);

    return SafeArea(
      child: Consumer<AppProvider>(
        builder: (_, __, ___) => MasonryGridView.builder(
          itemCount: provider.products.length,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (_, index) => provider.products[index].isFavourite
              ? ProductCard(
                  product: provider.products[index],
                  productIndex: index,
                  onFavouriteClick: () =>
                      provider.onFavouriteClick(provider.products[index]),
                )
              : SizedBox(),
        ),
      ),
    );
  }
}

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          userImage(provider),
          Text('Name: ${provider.user.name}'),
          Text('Email: ${provider.user.email}'),
          Text('Age: ${provider.user.age}'),
          Text('Weight: ${provider.user.weight}'),
          Text('Height: ${provider.user.height}'),
          Text('Gender: ${provider.user.gender}'),
        ],
      ),
    );
  }

  ClipOval userImage(AppProvider provider) {
    return ClipOval(
      child: CircleAvatar(
        radius: Dimensions.s40,
        backgroundColor: ColorManager.brownColor,
        child: provider.user.imageUrl == ""
            ? Padding(
                padding: const EdgeInsets.all(Dimensions.s16),
                child: Image.asset(
                  Constants.userAsset,
                  color: ColorManager.whiteColor,
                ),
              )
            : CachedNetworkImage(
                imageUrl: provider.user.imageUrl,
                width: Dimensions.s80,
                height: Dimensions.s80,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (_, __, ___) => Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.whiteColor,
                  ),
                ),
                errorWidget: (_, __, ___) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: Dimensions.s6,
                    left: Dimensions.s16,
                    right: Dimensions.s16,
                  ),
                  child: Image.asset(
                    Constants.errorAsset,
                  ),
                ),
              ),
      ),
    );
  }
}
