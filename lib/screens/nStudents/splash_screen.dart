import 'package:flutter/material.dart';
import 'package:nnotes/screens/nStudents/all_students_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  void moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AllStudentsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 220,
          height: 80,
          padding: EdgeInsetsGeometry.all(10),
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.school_outlined, size: 50, color: Colors.yellow),
              Text(
                "nStudents",
                style: TextStyle(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
