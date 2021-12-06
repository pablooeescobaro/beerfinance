import 'package:beer_app/data/service/theme_provider.dart';
import 'package:beer_app/routes/router.gr.dart';
import 'package:flutter/material.dart';

void main() => runApp(AppWidget());

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Nav Bar with Nested Routing',
      routerDelegate: _appRouter.delegate(),
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}