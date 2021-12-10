import 'package:beer_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hintText = '',
    this.errText,
    this.controller,
    this.type = TextInputType.text,
    this.inputFormatter,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focus,
  }) : super(key: key);

  final String hintText;
  final String? errText;
  final TextEditingController? controller;
  final TextInputType type;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputAction? textInputAction;
  final void Function()? onFieldSubmitted;
  final FocusNode? focus;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: BrandDuration.duration),
      curve: Curves.ease,
      height: errText != null ? 64 : 40,
      child: TextField(
        autofocus: true,
        keyboardType: type,
        inputFormatters: inputFormatter,
        controller: controller,
        textInputAction: textInputAction,
        onEditingComplete: onFieldSubmitted,
        focusNode: focus,
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
          errorText: errText,
          errorStyle: BS.reg12.apply(color: BC.brandRed60),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: BC.brandBlack, width: 2.0),
            borderRadius: const BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: BC.brandYellow, width: 2.0),
            borderRadius: const BorderRadius.all(
              Radius.circular(0),
            ),
          ),
        ),
      ),
    );
  }
}
