import 'package:api_veri/feature/characters/view/characters_page.dart';
import 'package:api_veri/feature/locations/view/locations_page.dart';
import 'package:api_veri/feature/following/view/following_page.dart';
import 'package:api_veri/feature/home_page/view/home_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => HomePage(child: child),
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CharactersPage()),
        ),
        GoRoute(
          path: '/locations',
          name: 'locations',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: LocationsPage()),
        ),
        GoRoute(
          path: '/following',
          name: 'following',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: FollowingPage()),
        ),
      ],
    ),
  ],
);
