import 'package:flutter/material.dart';
import 'package:nnotes/customWidgets/stu_snackbar.dart';
import 'package:nnotes/data/students.dart';
import 'package:nnotes/screens/nStudents/add_or_edit_student_screen.dart';
import 'package:nnotes/screens/nStudents/student_details_screen.dart';

class AllStudentsScreen extends StatefulWidget {
  const AllStudentsScreen({super.key});

  @override
  State<AllStudentsScreen> createState() => _AllStudentsScreenState();
}

class _AllStudentsScreenState extends State<AllStudentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Students"),
        actions: [Text("Students: ${students.length}"), SizedBox(width: 20)],
        centerTitle: false,
        backgroundColor: Colors.yellow[200],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newUser = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddOrEditStudentScreen(addStudent: true, editStudent: false),
            ),
          );
          if (newUser) {
            setState(() {});
          }
        },
        elevation: 2,
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: students.isEmpty
          ? Center(
              child: Text(
                "No students found!",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            )
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, idx) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudentDetailsScreen(sId: students[idx].id),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadiusGeometry.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "${students[idx].id}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudentDetailsScreen(sId: students[idx].id),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${students[idx].firstName} ${students[idx].lastName}",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              students[idx].email,
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              final updated = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddOrEditStudentScreen(
                                    sId: students[idx].id,
                                    editStudent: true,
                                  ),
                                ),
                              );
                              if (updated == true) {
                                setState(() {});
                              }
                            },
                            child: Icon(Icons.edit_note),
                          ),
                          InkWell(
                            onTap: () {
                              stuSnackbar(
                                context,
                                "${students[idx].firstName} ${students[idx].lastName} is deleted",
                                bgColor: Colors.red,
                              );
                              setState(() {
                                students.removeWhere(
                                  (s) => s.id == students[idx].id,
                                );
                              });
                            },
                            child: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
