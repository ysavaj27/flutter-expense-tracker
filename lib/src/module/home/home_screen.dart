import 'package:expense_tracker/routes.dart';
import 'package:expense_tracker/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthProvider>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await auth.logOut();
          if (!context.mounted) return;
          context.goNamed(Routes.login);
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
