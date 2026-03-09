import 'package:expense_tracker/src/providers/auth_provider.dart';
import 'package:expense_tracker/src/utils/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCTRL = TextEditingController();

  // File? selectedImage;
  // final picker = ImagePicker();
  //
  // Future<void> pickImage() async {
  //   final image = await picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 70,
  //   );
  //
  //   if (image != null) {
  //     setState(() {
  //       selectedImage = File(image.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // GestureDetector(
            //   onTap: pickImage,
            //   child: CircleAvatar(
            //     radius: 45,
            //     backgroundImage: selectedImage != null
            //         ? FileImage(selectedImage!)
            //         : null,
            //     child: selectedImage == null
            //         ? const Icon(Icons.camera_alt, size: 30)
            //         : null,
            //   ),
            // ),
            //
            // const SizedBox(height: 12),
            CustomTextField(controller: nameCTRL, hint: "Name"),
            const SizedBox(height: 12),
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
                    onPressed: () {
                      auth.signup(
                        email: emailCtrl.text,
                        password: passCtrl.text,
                        displayName: nameCTRL.text,
                        role: "member",
                        familyId: "rf20XovnLgJtzN2YAF65",
                      );
                    },
                    child: const Text("Create Account"),
                  ),

            if (auth.error != null)
              Text(auth.error!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
