import 'dart:ui';

import 'package:beer_app/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key, this.text = '', this.color, this.width, this.height})
      : super(key: key);

  final String text;
  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: color ?? BC.brandBlack),
      child: Text(
        text,
        style: BS.bold12.apply(color: BC.brandYellow),
        textAlign: TextAlign.center,
      ),
    );
  }
}
