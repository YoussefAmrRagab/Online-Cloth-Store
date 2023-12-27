import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../presentation/providers/app_provider.dart';
import 'package:provider/provider.dart';
import '../../util/extensions/extensions.dart';
import '../../domain/models/product_dto.dart';
import '../../util/constants/constants.dart';
import '../../util/resources/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.productIndex,
    required this.onFavouriteClick,
  });

  final ProductDTO product;
  final int productIndex;
  final VoidCallback onFavouriteClick;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  progressIndicatorBuilder: (_, __, ___) => SizedBox(
                      height: 160,
                      width: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.blackColor,
                        ),
                      )),
                  errorWidget: (_, __, ___) => Padding(
                    padding: const EdgeInsets.all(40),
                    child: Image.asset(
                      Constants.errorAsset,
                      color: ColorManager.brownColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                product.name,
                style: const TextStyle(
                  fontFamily: 'EncodeSans',
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  product.brand,
                  style: TextStyle(
                    fontFamily: 'EncodeSans',
                    fontWeight: FontWeight.w300,
                    color: ColorManager.lightGrayColor,
                    fontSize: 12,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${product.price}\$",
                    style: const TextStyle(
                      fontFamily: 'EncodeSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.yellow,
                      ),
                      4.marginWidth,
                      Text(
                        "${product.rating}",
                        style: const TextStyle(
                          fontFamily: 'EncodeSans',
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Selector<AppProvider, bool>(
          selector: (_, provider) =>
              provider.products[productIndex].isFavourite,
          builder: (_, isFavourite, __) => GestureDetector(
            onTap: onFavouriteClick,
            child: Container(
              padding: const EdgeInsets.only(
                right: 5,
                bottom: 4,
                top: 6,
                left: 5,
              ),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorManager.brownColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                isFavourite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: ColorManager.whiteColor,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
