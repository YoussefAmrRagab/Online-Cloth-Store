import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: const Center(child: Text("CartScreen")));
  }
}

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: const Center(child: Text("FavoriteScreen")));
  }
}

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: const Center(child: Text("SettingScreen")));
  }
}
