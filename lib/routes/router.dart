import 'package:auto_route/annotations.dart';
import 'package:beer_app/screens/activity/page.dart';
import 'package:beer_app/screens/home/home_page.dart';
import 'package:beer_app/screens/income/page.dart';
import 'package:beer_app/screens/saving/page.dart';
import 'package:beer_app/screens/spending/page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: HomePage,
    ),
    AutoRoute(
      path: '/activity',
      name: 'ActivityPageRoute',
      page: ActivityPage,
    ),
    AutoRoute(
      path: '/income',
      name: 'IncomePageRoute',
      page: IncomePage,
    ),
    AutoRoute(
      path: '/spending',
      name: 'SpendingPageRoute',
      page: SpendingPage,
    ),
    AutoRoute(
      path: '/saving',
      name: 'SavingPageRoute',
      page: SavingPage,
    ),
  ],
)
class $AppRouter {}
