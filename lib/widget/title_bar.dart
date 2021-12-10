import 'package:beer_app/styles.dart';
import 'package:flutter/material.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({Key? key, required this.title, required this.onTap})
      : super(key: key);

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (onTap == null) {
      return Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: BC.brandWhite, width: 2.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                title,
                style: BS.bold12.apply(color: BC.brandWhite),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: BC.brandWhite, width: 2.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  title,
                  style: BS.bold12.apply(color: BC.brandWhite),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  'Подробнее...',
                  style: BS.reg10.apply(color: BC.brandYellow),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
