import 'package:flutter/material.dart';
import 'package:nnotes/customWidgets/stu_snackbar.dart';
import 'package:nnotes/data/students.dart';

class AddOrEditStudentScreen extends StatefulWidget {
  final int? sId;
  final bool addStudent;
  final bool editStudent;

  const AddOrEditStudentScreen({
    super.key,
    this.sId,
    this.addStudent = false,
    this.editStudent = false,
  });

  @override
  State<AddOrEditStudentScreen> createState() => _AddOrEditStudentScreenState();
}

class _AddOrEditStudentScreenState extends State<AddOrEditStudentScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final departmentController = TextEditingController();
  bool isActiveController = true;
  Student? student;

  @override
  void initState() {
    super.initState();

    if (widget.editStudent && widget.sId != null) {
      student = students.firstWhere((s) => s.id == widget.sId);

      firstNameController.text = student!.firstName;
      lastNameController.text = student!.lastName;
      phoneController.text = student!.phone;
      emailController.text = student!.email;
      departmentController.text = student!.department;
      isActiveController = student!.isActive;
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.editStudent
              ? "Edit ${student!.firstName} ${student!.lastName}"
              : "Add Student",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: departmentController,
              decoration: const InputDecoration(
                labelText: "Department",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            SwitchListTile(
              title: const Text("Active"),
              value: isActiveController,
              onChanged: (value) {
                setState(() {
                  isActiveController = value;
                });
              },
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                // Edit student
                final index = students.indexWhere((s) => s.id == widget.sId);
                if (index != -1) {
                  students[index] = students[index].copyWith(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    department: departmentController.text,
                    isActive: isActiveController,
                  );
                  stuSnackbar(
                    context,
                    "Student updated",
                    bgColor: Colors.green,
                  );
                } else {
                  // Add new student
                  students.add(
                    Student(
                      id: students.isEmpty
                          ? 1
                          : students
                                    .map((e) => e.id)
                                    .reduce((a, b) => a > b ? a : b) +
                                1,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      department: departmentController.text,
                      isActive: isActiveController,
                    ),
                  );
                  stuSnackbar(context, "Student added", bgColor: Colors.green);
                }

                Navigator.pop(context, true);
              },
              child: Text(
                widget.editStudent ? "Update Student" : "Add Student",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
