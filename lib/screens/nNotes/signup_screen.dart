import 'package:flutter/material.dart';
import 'package:nnotes/customWidgets/general_text_field.dart';
import 'package:nnotes/data/users.dart';
import 'package:nnotes/screens/nNotes/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                ),
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "n",
                          style: TextStyle(color: Colors.yellow, fontSize: 25),
                        ),
                        TextSpan(
                          text: "Notes",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text("Sign Up Now", style: TextStyle(fontSize: 25)),
                  Text(
                    "Please fill the information below",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Column(
                spacing: 10,
                children: [
                  GeneralTextField(
                    label: "Username",
                    hint: "Enter your username",
                    controller: usernameController,
                  ),
                  GeneralTextField(
                    label: "Phone",
                    hint: "Enter your phone number",
                    controller: phoneController,
                  ),
                  GeneralTextField(
                    label: "Email",
                    hint: "Enter your email",
                    controller: emailController,
                  ),
                  GeneralTextField(
                    label: "Password",
                    hint: "Enter your password",
                    controller: passwordController,
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () async {
                  bool userExists = users.any(
                    (user) => user.email == emailController.text.trim(),
                  );

                  bool sameUsername = users.any(
                    (user) => user.username == usernameController.text.trim(),
                  );

                  if (userExists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "User already exists. Please login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (sameUsername) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "The username is not available!",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    users.add(
                      User(
                        username: usernameController.text.trim(),
                        phone: phoneController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          "Sign up successful",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );

                    await Future.delayed(const Duration(seconds: 2));

                    if (!mounted) return;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  }
                },
                child: const Text("Sign Up"),
              ),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Login here",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
