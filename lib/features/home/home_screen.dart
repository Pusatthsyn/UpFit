import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/icons/upfit0.png',
          height: 64,
        ),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Remix.menu_2_line)),
      ),
      body: Center(
        child: Text(
          'Hoş geldiniz!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
