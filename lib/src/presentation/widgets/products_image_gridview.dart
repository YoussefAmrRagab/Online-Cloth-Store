import 'package:flutter/material.dart';
import '../../presentation/widgets/product_image.dart';
import '../../util/extensions/extensions.dart';

class ProductsImageGridView extends StatelessWidget {
  const ProductsImageGridView(
      {super.key,
      required this.imageUrls,
      required this.imageBorderRadius,
      required this.crossAxisCount,
      required this.spacing});

  final List<String> imageUrls;
  final double imageBorderRadius;
  final int crossAxisCount;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.marginHeight,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (_, index) {
            return ProductImage(
              imageBorderRadius: imageBorderRadius,
              imageUrl: imageUrls[index],
            );
          },
        ),
      ],
    );
  }
}
