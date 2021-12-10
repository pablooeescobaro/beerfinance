import 'package:beer_app/styles.dart';
import 'package:flutter/material.dart';

class PageErrorHandler {
  static void showGenericError(
    BuildContext context, {
    bool isModal = false,
    String? errorMessage,
  }) {

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage ?? 'Что-то пошло не так', style: BS.reg14.apply(color: BC.brandWhite),)));
  }
}
