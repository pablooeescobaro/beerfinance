import 'dart:ui';

import 'package:beer_app/data/service/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BC {
  static final MaterialColor colorPrimary = MaterialColor(
    brandPrimary.value,
    <int, Color>{
      0: const Color(0xFFE7F8FF),
      50: const Color(0xFFB7E8FF),
      100: const Color(0xFFB7E9FF),
      200: const Color(0xFF87DBFF),
      300: const Color(0xFF57CCFF),
      400: const Color(0xFF0FB6FF),
      500: const Color(0xFF0FB6FF),
      600: const Color(0xFF0EA4E6),
      700: const Color(0xFF0B80B3),
      800: const Color(0xFF085B80),
      900: const Color(0xFF04374D),
    },
  );

  static const Color brandPrimary = Color(0xFF0FB6FF);
  static const Color brandText = Color(0xFF263238);
  static const Color brandError = Color(0xFFF44730);
  static const Color brandBlue100 = Color(0xFF0FB6FF);
  static const Color brandBlue60 = Color(0x990FB6FF);
  static const Color brandBlue50 = Color(0x800FB6FF);
  static const Color brandBlue40 = Color(0x660FB6FF);
  static const Color brandBlue20 = Color(0x330FB6FF);
  static const Color brandBlue10 = Color(0x1A0FB6FF);
  static const Color brandGreen100 = Color(0xFF70D361);
  static const Color brandGreen60 = Color(0x9970D361);
  static const Color brandGreen50 = Color(0x8070D361);
  static const Color brandGreen40 = Color(0x6670D361);
  static const Color brandGreen20 = Color(0x3370D361);
  static const Color brandGreen10 = Color(0x1A70D361);
  static const Color brandYellow100 = Color(0xFFFFCC00);
  static const Color brandYellow60 = Color(0x99FFCC00);
  static const Color brandYellow50 = Color(0x80FFCC00);
  static const Color brandYellow40 = Color(0x66FFCC00);
  static const Color brandYellow20 = Color(0x33FFCC00);
  static const Color brandYellow10 = Color(0x1AFFCC00);
  static const Color brandPink100 = Color(0xFFE74366);
  static const Color brandPink60 = Color(0x99E74366);
  static const Color brandPink50 = Color(0x80E74366);
  static const Color brandPink40 = Color(0x66E74366);
  static const Color brandPink20 = Color(0x33E74366);
  static const Color brandPink10 = Color(0x1AE74366);
  static const Color brandRed100 = Color(0xFFF44730);
  static const Color brandRed60 = Color(0x99F44730);
  static const Color brandRed50 = Color(0x80F44730);
  static const Color brandRed40 = Color(0x66F44730);
  static const Color brandRed20 = Color(0x33F44730);
  static const Color brandRed10 = Color(0x1AF44730);
  static const Color brandOrange100 = Color(0xFFFFA82D);
  static const Color brandOrange60 = Color(0x99FFA82D);
  static const Color brandOrange50 = Color(0x80FFA82D);
  static const Color brandOrange40 = Color(0x66FFA82D);
  static const Color brandOrange20 = Color(0x33FFA82D);
  static const Color brandOrange10 = Color(0x1AFFA82D);
  static const Color brandAccent2 = Color(0xFFFF788B);
  static const Color brandBlue = Color(0xFF0FB6FF);
  static const Color brandSecondary = Color(0xFF007AFF);
  static const Color brandSecondary2 = Color(0xFFB9DAFF);
  static const Color brandAccentGreen1 = Color(0xFF52B02B);
  static const Color brandAccentGreen2 = Color(0xFF98DB7C);
  static const Color brandYellow = Color(0xFFF18F01);

  static Color get brandWhite => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandWhite
      : BrandColorsLight.brandWhite;

  static Color get brandBlack => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandBlack
      : BrandColorsLight.brandBlack;

  static Color get brandGray9 => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandGray9
      : BrandColorsLight.brandGray9;

  static Color get brandGray8 => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandGray8
      : BrandColorsLight.brandGray8;

  static Color get brandGray7 => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandGray7
      : BrandColorsLight.brandGray7;

  static Color get brandGray6 => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandGray6
      : BrandColorsLight.brandGray6;

  static Color get brandGray5 => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandGray5
      : BrandColorsLight.brandGray5;

  static Color get brandGray4 => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandGray4
      : BrandColorsLight.brandGray4;

  static Color get brandGray3 => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandGray3
      : BrandColorsLight.brandGray3;

  static Color get brandGray2 => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandGray2
      : BrandColorsLight.brandGray2;

  static Color get brandGray1 => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandGray1
      : BrandColorsLight.brandGray1;

  static Color get brandGray0 => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandGray0
      : BrandColorsLight.brandGray0;

  static Color get brandShadowColor => ThemeProvider.isThemeDark
      ? Colors.black26
      : Colors.black.withOpacity(0.08);

  static Color get brandShadowColorHard => ThemeProvider.isThemeDark
      ? Colors.black54
      : Colors.black.withOpacity(0.2);

  static Color get brandChatLeftOtherMessage => ThemeProvider.isThemeDark
      ? const Color(0xFF4b4e5b)
      : BrandColorsLight.brandWhite;

  static Color get brandChatRightMyMessage => ThemeProvider.isThemeDark
      ? const Color(0xFF30382C)
      : const Color(0xFFE1FCD6);

  static String get brandChatBg => ThemeProvider.isThemeDark
      ? 'chat_background_dark.png'
      : 'chat_background_light.png';

  static Color get brandChatBgColor => ThemeProvider.isThemeDark
      ? BrandColorsDark.brandWhite
      : BrandColorsLight.brandGray2;
}

class BrandColorsLight {
  static const Color brandBlack = Color(0xFF1D201F);
  static const Color brandGray9 = Color(0xFF212121);
  static const Color brandGray8 = Color(0xFF424242);
  static const Color brandGray7 = Color(0xFF616161);
  static const Color brandGray6 = Color(0xFF757575);
  static const Color brandGray5 = Color(0xFF9E9E9E);
  static const Color brandGray4 = Color(0xFFBDBDBD);
  static const Color brandGray3 = Color(0xFFE0E0E0);
  static const Color brandGray2 = Color(0xFFEEEEEE);
  static const Color brandGray1 = Color(0xFFF5F5F5);
  static const Color brandGray0 = Color(0xFFFAFAFA);
  static const Color brandWhite = Color(0xFFFFFFFF);
  static const Color brandBackground = brandWhite;
}

class BrandColorsDark {
  static const Color brandBlack = BrandColorsLight.brandWhite;

  static const Color brandGray9 = BrandColorsLight.brandGray0;
  static const Color brandGray8 = BrandColorsLight.brandGray1;
  static const Color brandGray7 = BrandColorsLight.brandGray2;
  static const Color brandGray6 = BrandColorsLight.brandGray3;
  static const Color brandGray5 = BrandColorsLight.brandGray4;
  static const Color brandGray4 = BrandColorsLight.brandGray5;
  static const Color brandGray3 = BrandColorsLight.brandGray6;
  static const Color brandGray2 = BrandColorsLight.brandGray7;
  static const Color brandGray1 = BrandColorsLight.brandGray8;
  static const Color brandGray0 = BrandColorsLight.brandGray9;

  static const Color brandWhite = BrandColorsLight.brandBlack;
  static const Color brandBackground = brandWhite;
}

extension CustomColors on ThemeData {
  Color get colorSecondary => BC.brandSecondary;
}

abstract class BS {
  static TextStyle get light12 => ThemeProvider.isThemeDark
      ? BrandStylesDark.light12
      : BrandStylesLight.light12;

  static TextStyle get reg10 => ThemeProvider.isThemeDark
      ? BrandStylesDark.reg10
      : BrandStylesLight.reg10;

  static TextStyle get reg12 => ThemeProvider.isThemeDark
      ? BrandStylesDark.reg12
      : BrandStylesLight.reg12;

  static TextStyle get reg14 => ThemeProvider.isThemeDark
      ? BrandStylesDark.reg14
      : BrandStylesLight.reg14;

  static TextStyle get reg16 => ThemeProvider.isThemeDark
      ? BrandStylesDark.reg16
      : BrandStylesLight.reg16;

  static TextStyle get reg18 => ThemeProvider.isThemeDark
      ? BrandStylesDark.reg18
      : BrandStylesLight.reg18;

  static TextStyle get sBold12 => ThemeProvider.isThemeDark
      ? BrandStylesDark.sBold12
      : BrandStylesLight.sBold12;

  static TextStyle get sBold14 => ThemeProvider.isThemeDark
      ? BrandStylesDark.sBold14
      : BrandStylesLight.sBold14;

  static TextStyle get sBold16 => ThemeProvider.isThemeDark
      ? BrandStylesDark.sBold16
      : BrandStylesLight.sBold16;

  static TextStyle get sBold18 => ThemeProvider.isThemeDark
      ? BrandStylesDark.sBold18
      : BrandStylesLight.sBold18;

  static TextStyle get sBold24 => ThemeProvider.isThemeDark
      ? BrandStylesDark.sBold24
      : BrandStylesLight.sBold24;

  static TextStyle get bold12 => ThemeProvider.isThemeDark
      ? BrandStylesDark.bold12
      : BrandStylesLight.bold12;

  static TextStyle get bold14 => ThemeProvider.isThemeDark
      ? BrandStylesDark.bold14
      : BrandStylesLight.bold14;

  static TextStyle get bold16 => ThemeProvider.isThemeDark
      ? BrandStylesDark.bold16
      : BrandStylesLight.bold16;

  static TextStyle get bold18 => ThemeProvider.isThemeDark
      ? BrandStylesDark.bold18
      : BrandStylesLight.bold18;
}

abstract class BrandStylesLight {
  static TextStyle light12 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: BrandColorsLight.brandBlack,
  );

  static TextStyle reg10 = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: BrandColorsLight.brandBlack,
  );

  static TextStyle reg12 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: BrandColorsLight.brandBlack,
  );

  static TextStyle reg14 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: BrandColorsLight.brandBlack,
  );

  static TextStyle reg16 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: BrandColorsLight.brandBlack,
  );

  static TextStyle reg18 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: BrandColorsLight.brandBlack,
  );

  static TextStyle sBold12 = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: BrandColorsLight.brandBlack);

  static TextStyle sBold14 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: BrandColorsLight.brandBlack);

  static TextStyle sBold16 = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: BrandColorsLight.brandBlack);

  static TextStyle sBold18 = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: BrandColorsLight.brandBlack);

  static TextStyle sBold24 = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: BrandColorsLight.brandBlack);

  static TextStyle bold12 = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: BrandColorsLight.brandBlack);

  static TextStyle bold14 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: BrandColorsLight.brandBlack,
  );

  static TextStyle bold16 = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: BrandColorsLight.brandBlack);

  static TextStyle bold18 = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: BrandColorsLight.brandBlack);
}

abstract class BrandStylesDark {
  static TextStyle light12 =
      BrandStylesLight.light12.apply(color: BrandColorsDark.brandBlack);

  static TextStyle reg10 =
      BrandStylesLight.reg10.apply(color: BrandColorsDark.brandBlack);

  static TextStyle reg12 =
      BrandStylesLight.reg12.apply(color: BrandColorsDark.brandBlack);

  static TextStyle reg14 =
      BrandStylesLight.reg14.apply(color: BrandColorsDark.brandBlack);

  static TextStyle reg16 =
      BrandStylesLight.reg16.apply(color: BrandColorsDark.brandBlack);

  static TextStyle reg18 =
      BrandStylesLight.reg18.apply(color: BrandColorsDark.brandBlack);

  static TextStyle sBold12 =
      BrandStylesLight.sBold12.apply(color: BrandColorsDark.brandBlack);

  static TextStyle sBold14 =
      BrandStylesLight.sBold14.apply(color: BrandColorsDark.brandBlack);

  static TextStyle sBold16 =
      BrandStylesLight.sBold16.apply(color: BrandColorsDark.brandBlack);

  static TextStyle sBold18 =
      BrandStylesLight.sBold18.apply(color: BrandColorsDark.brandBlack);

  static TextStyle sBold24 =
      BrandStylesLight.sBold24.apply(color: BrandColorsDark.brandBlack);

  static TextStyle bold12 =
      BrandStylesLight.bold12.apply(color: BrandColorsDark.brandBlack);

  static TextStyle bold14 =
      BrandStylesLight.bold14.apply(color: BrandColorsDark.brandBlack);

  static TextStyle bold16 =
      BrandStylesLight.bold16.apply(color: BrandColorsDark.brandBlack);

  static TextStyle bold18 =
      BrandStylesLight.bold18.apply(color: BrandColorsDark.brandBlack);
}

@deprecated
extension CustomStyles on TextTheme {
  TextStyle get light12 => BS.light12;

  TextStyle get reg10 => BS.reg10;

  TextStyle get reg12 => BS.reg12;

  TextStyle get reg14 => BS.reg14;

  TextStyle get reg16 => BS.reg16;

  TextStyle get reg18 => BS.reg18;

  TextStyle get sBold12 => BS.sBold12;

  TextStyle get sBold14 => BS.sBold14;

  TextStyle get sBold16 => BS.sBold16;

  TextStyle get sBold18 => BS.sBold18;

  TextStyle get sBold24 => BS.sBold24;

  TextStyle get bold12 => BS.bold12;

  TextStyle get bold14 => BS.bold14;

  TextStyle get bold16 => BS.bold16;

  TextStyle get bold18 => BS.bold18;
}

class BrandShadow {
  static BoxShadow level1 = const BoxShadow(
    color: Color(0x29606170),
    blurRadius: 2,
    offset: Offset(0.0, 0.5),
  );

  static BoxShadow level4 = const BoxShadow(
    color: Color(0x29606170),
    blurRadius: 16,
    offset: Offset(0.0, 8),
  );
}

class BrandDuration {
  static int get duration => 200;
}

class AppThemeMode {
  static bool light = true;

  void switchTheme() {
    light = !light;
  }
}
