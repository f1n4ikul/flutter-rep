import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Список дел',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.add({
          'title': _controller.text,
          'isCompleted': false,
        });
      });
      _controller.clear();
    }
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index]['isCompleted'] = !_tasks[index]['isCompleted'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список дел'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Новая задача',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(
                    task['title'],
                    style: TextStyle(
                      decoration: task['isCompleted']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: task['isCompleted'],
                    onChanged: (value) {
                      _toggleTaskStatus(index);
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteTask(index);
                    },
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