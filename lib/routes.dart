import 'package:expense_tracker/src/module/auth/login_page.dart';
import 'package:expense_tracker/src/module/auth/signup_page.dart';
import 'package:expense_tracker/src/module/home/home_screen.dart';
import 'package:expense_tracker/src/module/init_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const init = 'init';
  static const login = 'login';
  static const signup = 'signup';
  static const home = 'home';
  static const details = 'details';

  static final router = GoRouter(
    initialLocation: '/init',
    routes: [
      GoRoute(
        name: init,
        path: '/init',
        builder: (context, state) => const InitScreen(),
      ),
      GoRoute(
        name: login,
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: signup,
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        name: home,
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),

      // 🔥 This is the new route with parameter
      // GoRoute(
      //   name: details,
      //   path: '/details/:id',   // <-- dynamic path parameter
      //   builder: (context, state) {
      //     final id = state.params['id']!;
      //     return DetailsScreen(id: id);
      //   },
      // ),
    ],
  );
}
