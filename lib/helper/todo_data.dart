import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/helper/order_data.dart';
import 'package:dailytodo/models/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Map<String, int> _priorities = {
//   'Easy': 1,
//   'Medium': 2,
//   'Hard': 3,
// };

class TodoData extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<Todo> todoList;

  Todo firstTodo;
  List<int> orders = [];

  Future<bool> getTodoFromDatabase() async {
    final List<Todo> result = [];
    await getOrder();
    todoList = await _databaseService.getTodoLists();

    sortTodo(todoList);
    // int completedNumber = todoList.length - completedTasks;

    // orders.forEach((id) {
    //   todoList.sort((todoA, todoB) => todoA.id.compareTo(id));
    // });

    // todoList.addAll(completedList);

    if (isCompleted) {
      getTodoData();
    }

    notifyListeners();

    return true;
  }

  void clearData() async {
    todoList.clear();
    orders.clear();
    updateOder(orders);
    await _databaseService.deleteAll();
    notifyListeners();
  }

  bool get isListEmpty {
    return todoList == null || todoList == [] || todoList.isEmpty;
  }

  void getTodoData() {
    firstTodo = todoList.first;
    notifyListeners();
  }

  Todo getTodo(int index) {
    return todoList[index];
  }

  void sortTodo(List<Todo> result) {
    result.sort((todoA, todoB) => todoA.status.compareTo(todoB.status));

    // todoList.sort((todoA, todoB) =>
    //     _priorities[todoB.priority].compareTo(_priorities[todoA.priority]));

    notifyListeners();
  }

  void addTodo(Todo todo, int id) {
    todoList.add(todo);
    // getOrder();
    orders.add(id);

    updateOder(orders);
    sortTodo(todoList);
    notifyListeners();
  }

  void deleteTodo(Todo todo) {
    // final int index = todoList.indexOf(todo);
    todoList.remove(todo);
    getOrder();
    orders.removeWhere((element) => element == todo.id);
    updateOder(orders);

    notifyListeners();
  }

  void updateOrder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Todo item = todoList.removeAt(oldIndex);
    todoList.insert(newIndex, item);
    final int previousItem = orders.removeAt(oldIndex);
    orders.insert(newIndex, previousItem);
    updateOder(orders);

    notifyListeners();
  }

  void updateOder(List<int> order) async {
    await OrderData.setOrder(order.map((e) => e.toString()).toList());
  }

  void getOrder() async {
    orders = await OrderData.getOrder();

    print("ORDER WHILE GETORDER CALLED:  $orders");
  }

  void updateTodo(Todo todo) {
    todoList[todoList.indexWhere((element) => element.id == todo.id)] = todo;
    // todoList.removeWhere((element) => element.status == 1);
    percentage;
    isCompleted;
    // getOrder();
    sortTodo(todoList);
    notifyListeners();
  }

  int get completedTasks {
    int completedTask =
        todoList.where((Todo todo) => todo.status == 1).toList().length;
    return completedTask;
  }

  int get todoCount {
    return todoList.length;
  }

  double get percentage {
    int ct = completedTasks;
    if (todoCount != 0) {
      double percentage = ct / todoCount;
      return percentage;
    }
    return 0.0;
  }

  bool get isCompleted {
    return percentage >= 0.99;
  }
}
