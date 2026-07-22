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
  List<Student> get filteredStudents {
    final searchedText = searchController.text.trim().toLowerCase();

    if (searchedText.isEmpty) {
      return students;
    }

    return students.where((s) {
      return s.firstName.toLowerCase().contains(searchedText) ||
          s.lastName.toLowerCase().contains(searchedText) ||
          s.email.toLowerCase().contains(searchedText) ||
          s.department.toLowerCase().contains(searchedText);
    }).toList();
  }

  TextEditingController searchController = TextEditingController();

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
          if (newUser == true) {
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
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Search student...",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredStudents.length,
                  itemBuilder: (context, idx) {
                    final student = filteredStudents[idx];
                    return Padding(
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
                                        StudentDetailsScreen(sId: student.id),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${student.id}",
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
                                        StudentDetailsScreen(sId: student.id),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${student.firstName} ${student.lastName}",
                                    style: TextStyle(fontSize: 15),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    student.email,
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
                                        builder: (_) => AddOrEditStudentScreen(
                                          sId: student.id,
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
                                      "${student.firstName} ${student.lastName} is deleted",
                                      bgColor: Colors.red,
                                    );
                                    setState(() {
                                      students.removeWhere(
                                        (s) => s.id == student.id,
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
                    );
                  },
                ),
              ],
            ),
    );
  }
}
