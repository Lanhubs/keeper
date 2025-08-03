import 'package:flutter/material.dart';
import 'package:keeper/pages/home/screens/addClient/widgets/Input.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Page'),

            Input(label: "Business Name:", onChanged: (value) {}),
            Input(label: "Email Address:", onChanged: (value) {}),
            Input(label: "Email Address:", onChanged: (value) {}),

            ElevatedButton(
              onPressed: () {
                // Add your login logic here
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Login with Google"),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  Colors.redAccent,
                ),
                alignment: Alignment.center,
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                    side: const BorderSide(color: Colors.redAccent),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
