import 'package:beer_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  static bool isThemeDark = false;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    isThemeDark = !isThemeDark;
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
      fontFamily: 'Rubik',
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: BrandColorsLight.brandBlack,
              systemNavigationBarIconBrightness: Brightness.dark),
          color: BrandColorsLight.brandBlack,
          iconTheme: const IconThemeData(
            color: BC.brandBlue,
          )),
      tabBarTheme: TabBarTheme(
        // indicator: const UnderlineTabIndicator(
        //     insets: EdgeInsets.symmetric(horizontal: 8),
        //     borderSide:
        //     BorderSide(color: BrandColors.brandAccent, width: 2)),
          labelStyle: BS.reg14.apply(color: BC.brandError),
          unselectedLabelStyle: BS.reg14.apply(color: BC.brandError),
          labelColor: BC.brandError,
          unselectedLabelColor: BC.brandError),
      toggleableActiveColor: BC.brandAccentGreen1,
      primarySwatch: BC.colorPrimary,
      scaffoldBackgroundColor: BrandColorsLight.brandBlack,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: BC.brandYellow,
        selectionHandleColor: BC.brandYellow,
        selectionColor: BC.brandYellow,
      ),
      dividerTheme: const DividerThemeData(color: BrandColorsLight.brandGray0, space: 1),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return BrandColorsLight.brandGray4;
          }
          if (states.contains(MaterialState.selected)) {
            return BC.brandYellow;
          }
          return BrandColorsLight.brandGray4;
        }),
      ),
      primaryColor: BC.brandYellow,
      backgroundColor: BrandColorsLight.brandBlack,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        // backgroundColor: BrandColors.brandAccent,
          foregroundColor: BrandColorsLight.brandBlack),
      /////NEW
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: BC.brandGray4),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: BC.brandPrimary),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: BC.brandError),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        errorStyle: BS.bold12.apply(color: BC.brandError),
        labelStyle: BS.reg16.apply(color: BC.brandGray5),
        hintStyle: BS.reg16.apply(color: BC.brandGray5),
      )
  );
}