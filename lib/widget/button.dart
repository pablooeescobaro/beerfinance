import 'dart:ui';

import 'package:beer_app/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.text = '',
      this.color,
      this.textColor,
      this.bGColor,
      this.width,
      this.height = 40,
      this.onTap,
      this.margin,
      this.disable = false})
      : super(key: key);

  final String text;
  final Color? color;
  final Color? textColor;
  final Color? bGColor;
  final double? width;
  final double? height;
  final double? margin;
  final void Function()? onTap;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disable ? null : onTap,
      child: Container(
        margin: EdgeInsets.all(margin ?? 0),
        width: width,
        height: height,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: disable ? BC.brandGray5 : color ?? BC.brandWhite),
            color: bGColor ?? Colors.transparent),
        child: Center(
          child: Text(
            text,
            style: BS.bold12.apply(
                color: disable ? BC.brandGray5 : textColor ?? BC.brandWhite),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
