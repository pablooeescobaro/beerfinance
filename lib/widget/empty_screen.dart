import 'package:beer_app/styles.dart';
import 'package:flutter/material.dart';

class CustomEmptyScreen extends StatelessWidget {
  const CustomEmptyScreen({Key? key, this.center = true}) : super(key: key);

  final bool center;

  @override
  Widget build(BuildContext context) {
    if (center) {
      return Center(
          child: Text(
        'Здесь пока ничего нет...',
        style: BS.reg12.apply(color: BC.brandWhite),
      ));
    } else {
      return Text(
        'Здесь пока ничего нет...',
        style: BS.reg12.apply(color: BC.brandWhite),
      );
    }
  }
}
