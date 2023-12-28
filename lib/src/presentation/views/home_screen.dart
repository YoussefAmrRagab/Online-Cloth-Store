import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../presentation/providers/home_provider.dart';
import '../../util/extensions/extensions.dart';
import '../../presentation/providers/app_provider.dart';
import '../../util/constants/constants.dart';
import '../../util/resources/colors.dart';
import '../../util/resources/dimens.dart';
import '../widgets/custom_filter_chip.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header(provider),
        searchAndFilterBar(),
        6.marginHeight,
        chipGroup(homeProvider, provider),
        4.marginHeight,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Consumer<AppProvider>(
              builder: (_, __, ___) => MasonryGridView.builder(
                itemCount: provider.products.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, index) => ProductCard(
                  product: provider.products[index],
                  productIndex: index,
                  onFavouriteClick: () =>
                      provider.onFavouriteClick(provider.products[index]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView chipGroup(
    HomeProvider homeProvider,
    AppProvider provider,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          16.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.chip1,
            builder: (_, value, __) => CustomFilterChip(
              text: 'All Items',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip1();
                provider.filterProducts(filtersText);
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.chip2,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Smart Casual Outfits',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip2();
                provider.filterProducts(filtersText);
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.chip3,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Uni Outfits',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip3();
                provider.filterProducts(filtersText);
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.chip4,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Sporty Outfits',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip4();
                provider.filterProducts(filtersText);
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.chip5,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Formal Outfits',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip5();
                provider.filterProducts(filtersText);
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
        ],
      ),
    );
  }

  Row searchAndFilterBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 54,
          width: 265,
          child: TextFormField(
            controller: _searchController,
            style: const TextStyle(
              fontSize: 16,
              height: 1,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search_rounded,
                color: ColorManager.grey2Color,
              ),
              hintText: 'Search clothes. . .',
              hintStyle: const TextStyle(
                fontFamily: 'EncodeSans',
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: outlineInputBorderStyle(),
              focusedBorder: outlineInputBorderStyle(),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 48,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: ColorManager.brownColor,
              ),
              child: SvgPicture.asset(
                'assets/images/filter.svg',
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder outlineInputBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: ColorManager.darkWhiteColor),
    );
  }

  Padding header(AppProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello, Welcome",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                provider.user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              )
            ],
          ),
          userImage(provider),
        ],
      ),
    );
  }

  ClipOval userImage(AppProvider provider) {
    return ClipOval(
      child: CircleAvatar(
        radius: Dimensions.s28,
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
