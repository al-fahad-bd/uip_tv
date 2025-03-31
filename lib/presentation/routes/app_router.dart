import 'package:go_router/go_router.dart';
import 'package:uip_tv/presentation/screens/home_screen.dart';
import 'package:uip_tv/presentation/screens/post_screen.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: HomeScreen.routeName,
    routes: [
      GoRoute(
        path: HomeScreen.routeName,
        name: HomeScreen.routeName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: PostScreen.routeName,
        name: PostScreen.routeName,
        builder: (context, state) => const PostScreen(),
      ),
    ],
  );
}
