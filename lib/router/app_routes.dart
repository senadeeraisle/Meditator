import 'package:go_router/go_router.dart';
import 'package:meditator/pages/main_screen.dart';
import 'package:meditator/router/route_names.dart';

class AppRoutes {
  final routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.mainPage,
        builder: (context, state) {
          return MainScreen();
        },
      ),
    ],
  );
}
