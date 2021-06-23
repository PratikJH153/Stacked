import 'package:dailytodo/helper/todo_data.dart';
import 'package:dailytodo/views/add_todo_page.dart';
import 'package:dailytodo/views/todo_list.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/floatingactionButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatelessWidget {
  static const id = '/todoListPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(
        backgroundColor: Colors.grey[900],
        context: context,
        icon: CupertinoIcons.add,
        location: AddTodoPage.id,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    iconSize: 25,
                    icon: Icon(CupertinoIcons.arrow_turn_up_left),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      bottom: 25,
                    ),
                    child: Text(
                      "Your Todo's",
                      style: kTextFieldHintTextStyle,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () async {
                      await Provider.of<TodoData>(context, listen: false)
                          .clearData();
                    },
                    child: Text("Clear all"),
                    style: TextButton.styleFrom(
                      primary: Colors.red[400],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(style: kHintTextFieldTextStyle, children: [
                  TextSpan(
                    text: "You have ",
                  ),
                  TextSpan(
                      text:
                          "${Provider.of<TodoData>(context).completedTasks}/${Provider.of<TodoData>(context).todoCount}",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                        fontSize: 20,
                        letterSpacing: 2,
                      )),
                  TextSpan(
                    text: " Tasks left",
                  ),
                ]),
              ),
              LinearPercentIndicator(
                backgroundColor: kprimaryColor,
                linearGradient: LinearGradient(colors: [
                  Color(0xFF4797ff),
                  Color(0xFF643dff),
                  Color(0xFFff7092),
                  Color(0xFFf5426c),
                ]),
                percent: Provider.of<TodoData>(context).percentage != double.nan
                    ? Provider.of<TodoData>(context).percentage
                    : 0.0,
                lineHeight: 2,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 1500,
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 15,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: TodoList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// FutureBuilder(
//                 future: todoList,
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return Container();
//                   }

//                   final int completedTodo = snapshot.data
//                       .where((Todo todo) => todo.status == 1)
//                       .toList()
//                       .length;

//                   return Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       // onReorder: (oldIndex, newIndex) => setState(() {}),
//                       itemBuilder: (context, index) {
//                         if (snapshot.data.length == 0) {
//                           return Container();
//                         }
//                         if (index == 0) {
//                           return RichText(
//                             text: TextSpan(
//                               children: <TextSpan>[
//                                 TextSpan(
//                                   text: "You have ",
//                                   style: TextStyle(
//                                       color: Colors.grey,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 17),
//                                 ),
//                                 TextSpan(
//                                   text:
//                                       " $completedTodo/${snapshot.data.length} ",
//                                   style: TextStyle(
//                                       color: kcanvasColor,
//                                       fontWeight: FontWeight.bold,
//                                       letterSpacing: 1.2,
//                                       fontSize: 18),
//                                 ),
//                                 TextSpan(
//                                   text: " tasks to complete",
//                                   style: TextStyle(
//                                       color: Colors.grey,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 17),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }
//                         var todo = snapshot.data[index - 1];
//                         return Slidable(
//                           actionPane: SlidableDrawerActionPane(),
//                           secondaryActions: [
//                             IconButton(
//                               icon: Icon(CupertinoIcons.pencil_outline),
//                               onPressed: () {},
//                             ),
//                             IconButton(
//                               icon: Icon(CupertinoIcons.delete_simple),
//                               onPressed: () {},
//                             ),
//                           ],
//                           key: ValueKey(todo),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 15, vertical: 5),
//                             decoration: BoxDecoration(
//                               color: kprimaryColor,
//                               // borderRadius: BorderRadius.circular(10),
//                               border: Border(
//                                 left: BorderSide(
//                                   color: priorities[todo.priority],
//                                   width: 3,
//                                 ),
//                               ),
//                             ),
//                             margin: EdgeInsets.only(top: 20),
//                             child: ListTile(
//                               key: ValueKey(todo),
//                               title: Text(
//                                 todo.title,
//                                 style: kTextFieldHintTextStyle.copyWith(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               trailing: Icon(Icons.drag_handle_rounded),
//                             ),
//                           ),
//                         );
//                       },
//                       itemCount: 1 + snapshot.data.length,
//                     ),
//                   );
//                 },
//               ),