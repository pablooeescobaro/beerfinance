import 'package:beer_app/styles.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key, this.text = '', this.style, this.color})
      : super(key: key);

  final String text;
  final TextStyle? style;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,
            style: style ?? BS.bold18.apply(color: color ?? BC.brandWhite))
      ],
    );
  }
}
