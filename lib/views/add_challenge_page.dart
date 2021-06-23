import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/models/challenge.dart';
import 'package:dailytodo/views/wrapper.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/priority_widget.dart';
import 'package:dailytodo/widgets/snackbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddChallengePage extends StatefulWidget {
  static const id = '/addChallengePage';
  final Challenge challenge;

  AddChallengePage({this.challenge});

  @override
  _AddChallengePageState createState() => _AddChallengePageState();
}

class _AddChallengePageState extends State<AddChallengePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _desController = TextEditingController();
  int totalDays;

  _submit() async {
    if (_titleController.text.trim().isNotEmpty &&
        _titleController.text.trim().length > 3 &&
        totalDays != null) {
      Challenge challenge = Challenge(
        title: _titleController.text.trim(),
        des: _desController.text.trim(),
        completedDays: 0,
        isDone: 0,
        totalDays: totalDays,
        doneDate: DateTime.now().subtract(
          Duration(days: 1),
        ),
      );
      if (widget.challenge == null) {
        await DatabaseService.instance.insertChallenge(challenge);
      } else {
        challenge.id = widget.challenge.id;
        challenge.title = _titleController.text.trim();
        challenge.completedDays = widget.challenge.completedDays;
        challenge.isDone = widget.challenge.isDone;
        challenge.doneDate = widget.challenge.doneDate;
        challenge.des = _desController.text.trim();

        await DatabaseService.instance.updateChallenge(challenge);
      }
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Wrapper.id, (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBarWidget(
          title: totalDays != null
              ? "Please enter a valid title"
              : "Please select the days",
          color: Colors.red[400],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.challenge != null) {
      _titleController.text = widget.challenge.title;
      _desController.text = widget.challenge.des;
      totalDays = widget.challenge.totalDays;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            "Add a Challenge",
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
                      Container(
                        margin: EdgeInsets.only(left: 2),
                        child: priorityWidget(
                          title: "Challenge",
                          color: kaccentColor,
                          onTap: () {},
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: containerDecoration,
                        child: TextField(
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          autocorrect: true,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 12),
                            border: InputBorder.none,
                            hintText: "Enter your Challenge",
                            hintStyle: kHintTextFieldTextStyle,
                          ),
                          controller: _titleController,
                        ),
                      ),
                      Container(
                        height: 100,
                        margin: EdgeInsets.only(top: 20),
                        decoration: containerDecoration,
                        child: TextField(
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          autocorrect: true,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 12),
                            border: InputBorder.none,
                            hintText: "Enter the challenge Description",
                            hintStyle: kHintTextFieldTextStyle,
                          ),
                          controller: _desController,
                        ),
                      ),
                      widget.challenge == null
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              decoration: containerDecoration,
                              child: TextField(
                                readOnly: true,
                                onTap: () {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        child: CupertinoPicker(
                                          itemExtent: 50,
                                          useMagnifier: true,
                                          onSelectedItemChanged: (val) {
                                            setState(() {
                                              totalDays = val + 1;
                                            });
                                          },
                                          children: List.generate(
                                            100,
                                            (index) => Center(
                                              child: Text(
                                                "${index + 1}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 12),
                                  border: InputBorder.none,
                                  hintText: totalDays != null
                                      ? "$totalDays Days"
                                      : "Select Number of Days",
                                  hintStyle: totalDays != null
                                      ? kTextFieldHintTextStyle.copyWith(
                                          fontSize: 18,
                                          color: Colors.white,
                                        )
                                      : kHintTextFieldTextStyle,
                                ),
                              ),
                            )
                          : Container(),
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
