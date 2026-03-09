import 'package:expense_tracker/routes.dart';
import 'package:expense_tracker/src/providers/auth_provider.dart';
import 'package:expense_tracker/src/utils/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'signup_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void initState() {
    emailCtrl.text = 'savajyash8866@gmail.com';
    passCtrl.text = 'Yash@123#';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login", style: TextStyle(fontSize: 32)),

            const SizedBox(height: 20),
            CustomTextField(controller: emailCtrl, hint: "Email"),
            const SizedBox(height: 12),
            CustomTextField(
              controller: passCtrl,
              hint: "Password",
              isPassword: true,
            ),

            const SizedBox(height: 20),

            auth.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      await auth.login(emailCtrl.text, passCtrl.text);
                      if (!context.mounted) return;
                      context.pushNamed(Routes.home);
                    },
                    child: const Text("Login"),
                  ),

            if (auth.error != null)
              Text(auth.error!, style: const TextStyle(color: Colors.red)),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignupScreen()),
                );
              },
              child: const Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
