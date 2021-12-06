import 'package:auto_route/annotations.dart';
import 'package:beer_app/screens/home_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: HomePage,
    )
  ],
)
class $AppRouter {}