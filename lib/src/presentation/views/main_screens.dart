import 'package:flutter/material.dart';
import '../../presentation/widgets/custom_bottom_navigation_bar.dart';
import '../../util/resources/colors.dart';
import '../views/screens.dart';
import '../views/home_screen.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  final screens = [
    HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
    SettingScreen()
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            screens[index],
            Container(
              color: Colors.white,
              height: 44,
            ),
            CustomBottomNavigationBar(
              radiusSize: 100,
              height: 62,
              backgroundColor: ColorManager.brownColor,
              index: index,
              icons: [
                Icon(
                  Icons.home_rounded,
                  color: ColorManager.whiteColor,
                ),
                Icon(
                  Icons.shopping_cart_rounded,
                  color: ColorManager.whiteColor,
                ),
                Icon(
                  Icons.favorite_rounded,
                  color: ColorManager.whiteColor,
                ),
                Icon(
                  Icons.settings_rounded,
                  color: ColorManager.whiteColor,
                ),
              ],
              hoverColor: ColorManager.whiteColor.withOpacity(0.2),
              onTap: (int index) {
                setState(() {
                  this.index = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
