import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color primaryColor = Color(0xFFC8A27C);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5E6D3),
        primaryColor: primaryColor,
        fontFamily: 'Poppins',
      ),
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Map<String, dynamic>> tasks = [];
  TextEditingController controller = TextEditingController();

  void addTask() {
    if (controller.text.isEmpty) return;
    setState(() {
      tasks.add({
        'title': controller.text,
        'done': false,
      });
    });
    controller.clear();
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]['done'] = !tasks[index]['done'];
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks"),
        backgroundColor: Color(0xFFC8A27C),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter task...",
                filled: true,
                fillColor: Color(0xFFEAD7C0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: addTask,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFC8A27C),
            ),
            child: Text("Add Task"),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color(0xFFEAD7C0),
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      tasks[index]['title'],
                      style: TextStyle(
                        decoration: tasks[index]['done']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: Color(0xFF5A4634),
                      ),
                    ),
                    leading: Checkbox(
                      value: tasks[index]['done'],
                      onChanged: (_) => toggleTask(index),
                      activeColor: Color(0xFFC8A27C),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.brown),
                      onPressed: () => deleteTask(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}