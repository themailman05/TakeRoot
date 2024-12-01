import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:takeroot/layout.dart';
import 'package:takeroot/screens/home.dart';
import 'package:takeroot/screens/login.dart';
import 'package:takeroot/screens/shop.dart';
import 'package:takeroot/splash.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state, child) {
            return NoTransitionPage(
                child: AppLayout(
              location: state.matchedLocation,
              child: child,
            ));
          },
          routes: [
            GoRoute(
                path: '/home',
                parentNavigatorKey: _shellNavigatorKey,
                pageBuilder: (BuildContext content, GoRouterState state) {
                  return const NoTransitionPage(child: TakeRootHome());
                }),
            GoRoute(
                path: '/shop',
                parentNavigatorKey: _shellNavigatorKey,
                pageBuilder: (BuildContext content, GoRouterState state) {
                  return const NoTransitionPage(child: ShopScreen());
                }),
          ])
    ],
    errorBuilder: (context, state) => ErrorScreen(goException: state.error));

class ErrorScreen extends StatelessWidget {
  final GoException? goException;
  const ErrorScreen({super.key, this.goException});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Something\'s missing...',
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text('The requested resource could not be found.'),
          TextButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Go Home'))
        ],
      )),
    );
  }
}
