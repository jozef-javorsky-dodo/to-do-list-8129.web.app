import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '📝 To-Do-List 📒',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final List<ToDoItem> _todos = [
    ToDoItem(text: 'Flutter SinglePage-web-App.'),
    ToDoItem(text: '~~~~~~~~~~~'),
    ToDoItem(text: '= = = = = ='),
    ToDoItem(text: 'github.com/jozef-javorsky-dodo'),
    ToDoItem(text: 'jozef.javorsky.dodo@gmail.com')
  ];

  void _addTodo(String todo) {
    setState(() {
      _todos.add(ToDoItem(text: todo));
    });
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF969696),
      body: Center(
        child: SizedBox(
          width: 550,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AddTodoForm(onAdd: _addTodo),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ToDoList(
                      todos: _todos,
                      onToggle: _toggleTodo,
                      onRemove: _removeTodo,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ToDoItem {
  String text;
  bool isDone = false;

  ToDoItem({required this.text});
}

class ToDoList extends StatelessWidget {
  final List<ToDoItem> todos;
  final Function(int) onToggle;
  final Function(int) onRemove;

  const ToDoList({
    super.key,
    required this.todos,
    required this.onToggle,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
          title: Text(
            todo.text,
            style: TextStyle(
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          leading: Checkbox(
            value: todo.isDone,
            onChanged: (value) => onToggle(index),
            shape: const CircleBorder(),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => onRemove(index),
          ),
        );
      },
    );
  }
}

class AddTodoForm extends StatefulWidget {
  final Function(String) onAdd;

  const AddTodoForm({super.key, required this.onAdd});

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  void _submitTodo() {
    if (_todoController.text.isNotEmpty) {
      widget.onAdd(_todoController.text);
      _todoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _todoController,
            decoration: const InputDecoration(
              hintText: 'Add a new to-do note.',
              border: InputBorder.none, // Remove default border
            ),
            onSubmitted: (value) => _submitTodo(), // Submit on Enter
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _submitTodo, // Or use a different icon
        ),
      ],
    );
  }
}
