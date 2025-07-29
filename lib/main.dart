import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ToDoList());
}

class Task {
  String title;
  bool isDone;
  Task({required this.title, this.isDone = false});
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  TextEditingController taskController = TextEditingController();
  List<Task> task = [];

  @override
  Widget build(BuildContext context) {
    int checkedCount = task.where((t) => t.isDone).length;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.dark(primary: Colors.white),
        checkboxTheme: CheckboxThemeData(side: BorderSide(color: Colors.amber)),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.purpleAccent),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Your To Do',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: taskController,
                decoration: InputDecoration(
                  suffixIcon: Card(
                    margin: EdgeInsets.all(5),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        if (taskController.text.isNotEmpty) {
                          setState(() {
                            task.add(Task(title: taskController.text.trim()));
                            taskController.clear();
                          });
                        }
                      },
                      icon: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                  hintText: 'Add new task',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: task.length,
                itemBuilder: (context, index) {
                  return Card(
                    surfaceTintColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.purpleAccent),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(3),
                      title: Text(
                        task[index].title,
                        style: TextStyle(
                          decoration:
                              task[index].isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                          color:
                              task[index].isDone ? Colors.grey : Colors.white,
                        ),
                      ),
                      leading: Checkbox(
                        value: task[index].isDone,
                        onChanged: (bool? newValue) {
                          setState(() {
                            task[index].isDone = newValue!;
                          });
                        },
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                          top: 3,
                          bottom: 3,
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              task.removeAt(index);
                            });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Completed task: $checkedCount of ${task.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
