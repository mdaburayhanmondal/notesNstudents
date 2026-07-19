import 'package:flutter/material.dart';
import 'package:nnotes/data/students.dart';

class StudentDetailsScreen extends StatefulWidget {
  final int sId;
  const StudentDetailsScreen({super.key, required this.sId});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final student = students.firstWhere((s) => widget.sId == s.id);
    return Scaffold(
      appBar: AppBar(title: Text("Student Details")),
      body: Center(
        child: Container(
          padding: EdgeInsetsGeometry.all(20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "ID: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${student.id}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Status: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: student.isActive ? Colors.green : Colors.red,
                          borderRadius: BorderRadiusGeometry.circular(20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Name: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("${student.firstName} ${student.lastName}"),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Phone: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(student.phone),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Email: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(student.email),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Department: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(student.department),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
