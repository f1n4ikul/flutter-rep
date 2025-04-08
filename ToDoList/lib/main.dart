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

  // Фильтр для отображения задач
  String _filter = 'all'; // Возможные значения: 'all', 'completed', 'uncompleted'

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

  void _editTask(int index) {
    final TextEditingController editController = TextEditingController();
    editController.text = _tasks[index]['title'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать задачу'),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(labelText: 'Название задачи'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _tasks[index]['title'] = editController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get _filteredTasks {
    switch (_filter) {
      case 'completed':
        return _tasks.where((task) => task['isCompleted']).toList();
      case 'uncompleted':
        return _tasks.where((task) => !task['isCompleted']).toList();
      default:
        return _tasks;
    }
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
              itemCount: _filteredTasks.length,
              itemBuilder: (context, index) {
                final task = _filteredTasks[index];
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
                      _toggleTaskStatus(_tasks.indexOf(task));
                    },
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _editTask(_tasks.indexOf(task));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteTask(_tasks.indexOf(task));
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text('Все задачи'),
                      onTap: () {
                        setState(() {
                          _filter = 'all';
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Выполненные'),
                      onTap: () {
                        setState(() {
                          _filter = 'completed';
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Невыполненные'),
                      onTap: () {
                        setState(() {
                          _filter = 'uncompleted';
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            child: const Icon(Icons.menu),
          ),
        ),
      ),
    );
  }
}