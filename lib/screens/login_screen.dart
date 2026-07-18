import 'package:flutter/material.dart';
import 'package:nnotes/customWidgets/general_text_field.dart';
import 'package:nnotes/data/users.dart';
import 'package:nnotes/screens/home_screen.dart';
import 'package:nnotes/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRemembered = false;

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
              Icon(
                Icons.person_2_outlined,
                size: 150,
                color: Colors.deepOrange,
              ),
              Column(
                children: [
                  Text(
                    "Welcome back!",
                    style: TextStyle(fontSize: 30, color: Colors.green),
                  ),
                  Text("Login Now", style: TextStyle(fontSize: 20)),
                ],
              ),
              Column(
                spacing: 10,
                children: [
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

                  if (!userExists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "User not found!",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    bool validUser = users.any(
                      (user) =>
                          user.email == emailController.text.trim() &&
                          user.password == passwordController.text,
                    );

                    if (validUser) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            "Login Successful.",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                      await Future.delayed(Duration(seconds: 1));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            "Wrong credentials!",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Text("Login"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isRemembered,
                        onChanged: (val) {
                          setState(() {
                            isRemembered = val!;
                          });
                        },
                      ),
                      Text("Remember Me"),
                    ],
                  ),
                  InkWell(
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.red),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text(
                      "Sign up now",
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
