import 'package:flutter/material.dart';

void main() {
  runApp(MyTaskApp());
}

class MyTaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<String> _taskList = <String>[];
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView(children: _buildTaskList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTask(String task) {
    setState(() {
      _taskList.add(task);
    });
    _taskController.clear();
  }

  Widget _taskItem(String task) {
    return ListTile(
      title: Text(task),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            _taskList.remove(task);
          });
        },
      ),
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add a new task'),
            content: TextField(
              controller: _taskController,
              decoration: InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Add'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTask(_taskController.text);
                },
              ),
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<Widget> _buildTaskList() {
    final List<Widget> _taskWidgets = <Widget>[];
    for (String task in _taskList) {
      _taskWidgets.add(_taskItem(task));
    }
    return _taskWidgets;
  }
}
