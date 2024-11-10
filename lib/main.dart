import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
      ),
      home: TodoListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  // Add a new task
  void _addTask(String task) {
    setState(() {
      _tasks.add({'task': task, 'completed': false});
    });
    _taskController.clear();
  }

  // Delete a task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Toggle task completion
  void _toggleCompletion(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
  }

  // Show dialog to add a new task
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Add New Task', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(
              hintText: 'Enter task',
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.redAccent)),
            ),
            TextButton(
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  _addTask(_taskController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add', style: TextStyle(color: Colors.tealAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Color(0xFF1E1E1E),
      body: _tasks.isEmpty
          ? Center(
              child: Text(
                'No tasks added yet!',
                style: TextStyle(color: Colors.white54, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[850],
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        _tasks[index]['completed']
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: _tasks[index]['completed']
                            ? Colors.tealAccent
                            : Colors.white,
                      ),
                      onPressed: () => _toggleCompletion(index),
                    ),
                    title: Text(
                      _tasks[index]['task'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        decoration: _tasks[index]['completed']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _deleteTask(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.tealAccent,
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
