import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/models/timeline.dart';
import 'package:dailytodo/views/wrapper.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/priority_widget.dart';
import 'package:dailytodo/widgets/snackbar_widget.dart';
import 'package:dailytodo/widgets/textFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTimeLinePage extends StatefulWidget {
  static const id = '/addtimeline';

  final Timeline timeline;

  AddTimeLinePage({this.timeline});

  @override
  _AddTimeLinePageState createState() => _AddTimeLinePageState();
}

class _AddTimeLinePageState extends State<AddTimeLinePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  int day;

  void gettingRecentDay() async {
    int days = await TimeLinePref.getday();
    setState(() {
      day = days;
    });
  }

  _submit() async {
    if (_titleController.text.trim().isNotEmpty &&
        _titleController.text.trim().length > 3) {
      Timeline timeline = Timeline(
        title: _titleController.text.trim(),
        des: _desController.text.trim(),
        dateTime: DateTime.now(),
        day: day,
      );
      if (widget.timeline == null) {
        await DatabaseService.instance.insertTimeLine(timeline);
        TimeLinePref.setday(day + 1);
      } else {
        timeline.id = widget.timeline.id;
        timeline.title = _titleController.text.trim();
        timeline.des = _desController.text.trim();

        await DatabaseService.instance.updateTimeline(timeline);
      }

      Navigator.of(context)
          .pushNamedAndRemoveUntil(Wrapper.id, (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBarWidget(
          title: "Please enter a valid title",
          color: Colors.red[400],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.timeline != null) {
      _desController.text = widget.timeline.des;
      _titleController.text = widget.timeline.title;
      day = widget.timeline.day;
    } else {
      gettingRecentDay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          backgroundColor: Colors.grey[900],
          child: Icon(
            CupertinoIcons.clear,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            iconSize: 25,
                            icon: Icon(CupertinoIcons.arrow_turn_up_left),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            "Add your Day",
                            style: kTextFieldHintTextStyle,
                          ),
                          Spacer(),
                          IconButton(
                            iconSize: 30,
                            icon: Icon(CupertinoIcons.checkmark_alt),
                            onPressed: _submit,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      dayWidget(
                        title: "Day $day",
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        decoration: containerDecoration,
                        child: TextFieldWidget(
                          hintText: "Title",
                          textEditingController: _titleController,
                        ),
                      ),
                      Container(
                        height: 80,
                        decoration: containerDecoration,
                        margin: EdgeInsets.only(top: 20),
                        child: TextFieldWidget(
                          hintText: "Description",
                          textEditingController: _desController,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
