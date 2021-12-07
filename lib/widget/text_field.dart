import 'package:beer_app/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.hintText = '',
      this.controller,
      this.type = TextInputType.text})
      : super(key: key);

  final String hintText;
  final TextEditingController? controller;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        autofocus: true,
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          hintText: hintText,
          hintStyle: BS.reg14.apply(color: BC.brandGray5),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: BC.brandYellow, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: BC.brandBlack, width: 2.0),
            borderRadius: const BorderRadius.all(
              Radius.circular(0),
            ),
          ),
        ),
      ),
    );
  }
}
