import 'package:flutter/material.dart';
import 'package:nnotes/customWidgets/general_text_field.dart';
import 'package:nnotes/data/notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool addTask = false;
bool editTask = false;
int? editingIndex;

TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  void refreshScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Note App",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: notes.isEmpty
          ? const Center(child: Text("No notes found!"))
          : Stack(
              children: [
                ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, idx) => Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.yellow[200],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        child: Text(
                          "${idx + 1}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        "${notes[idx]["title"]}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${notes[idx]["description"]}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  editTask = true;
                                  addTask = false;
                                  editingIndex = idx;
                                  titleController.text = notes[idx]["title"]!;
                                  descriptionController.text =
                                      notes[idx]["description"]!;
                                });
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  notes.removeAt(idx);

                                  if (editingIndex == idx) {
                                    editTask = false;
                                  }
                                });
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                if (addTask || editTask)
                  Positioned(
                    top: 100,
                    left: 10,
                    right: 10,
                    child: InputContainer(onActionComplete: refreshScreen),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            addTask = !addTask;
            editTask = false;
            editingIndex = null;
            titleController.text = "";
            descriptionController.text = "";
          });
        },
        child: addTask == true
            ? const Icon(Icons.cancel)
            : const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class InputContainer extends StatefulWidget {
  final VoidCallback onActionComplete;

  const InputContainer({super.key, required this.onActionComplete});

  @override
  State<InputContainer> createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  bool isEmptyField = false;

  @override
  void initState() {
    super.initState();

    void clearError() {
      if (isEmptyField) {
        setState(() {
          isEmptyField = false;
        });
      }
    }

    titleController.addListener(clearError);
    descriptionController.addListener(clearError);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.yellow[200],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.5),
            offset: const Offset(4, 4),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          GeneralTextField(
            controller: titleController,
            label: "Task Title",
            labelColor: Colors.deepOrange,
            hint: "Enter task title",
          ),
          Expanded(
            child: GeneralTextField(
              controller: descriptionController,
              label: "Task Description",
              labelColor: Colors.deepOrange,
              hint: "Enter task description",
              expands: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    isEmptyField = false;
                  });

                  addTask = false;
                  editTask = false;
                  editingIndex = null;

                  titleController.clear();
                  descriptionController.clear();

                  widget.onActionComplete();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  if (titleController.text.trim().isEmpty ||
                      descriptionController.text.trim().isEmpty) {
                    setState(() {
                      isEmptyField = true;
                    });
                    return;
                  }

                  setState(() {
                    isEmptyField = false;
                  });

                  if (addTask) {
                    notes.add({
                      "title": titleController.text.trim(),
                      "description": descriptionController.text.trim(),
                    });
                  } else if (editTask && editingIndex != null) {
                    notes[editingIndex!] = {
                      "title": titleController.text.trim(),
                      "description": descriptionController.text.trim(),
                    };
                  }

                  addTask = false;
                  editTask = false;
                  editingIndex = null;

                  titleController.clear();
                  descriptionController.clear();

                  widget.onActionComplete();
                },
                child: Text(
                  addTask ? "Add" : "Save",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          if (isEmptyField) Text("All fields are required."),
        ],
      ),
    );
  }
}
