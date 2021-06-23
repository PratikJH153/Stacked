import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/helper/display_name.dart';
import 'package:dailytodo/models/timeline.dart';
import 'package:dailytodo/views/wrapper.dart';
import 'package:dailytodo/widgets/back_button.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/next_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AskNamePage extends StatelessWidget {
  static const id = '/asknamePage';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  void getName(BuildContext context) async {
    final _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      DisplayName.setName(_nameController.text.trim());
      TimeLinePref.setday(1);
      await DatabaseService.instance.insertDay();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Wrapper.id, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = getHeight(context);
    final double width = getWidth(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: width,
                  padding: const EdgeInsets.all(30),
                  decoration: containerDecoration.copyWith(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Daily Todo",
                        style: kIntroTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "A place where growth is step by step with satisfaction of the work done in a day",
                        textAlign: TextAlign.center,
                        style: kDesTextStyle,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Flexible(
                        child: Image.asset(
                          "assets/images/info.png",
                          width: width * 0.7,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Okay firstly,\nhow can I call you?",
                        style: kTextFieldHintTextStyle,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: Container(
                              decoration: containerDecoration,
                              child: TextFormField(
                                controller: _nameController,
                                autofocus: true,
                                keyboardType: TextInputType.text,
                                autocorrect: true,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 12),
                                  border: InputBorder.none,
                                  hintText: "Enter your name",
                                  hintStyle: kHintTextFieldTextStyle,
                                ),
                                validator: (val) {
                                  return val.length < 3
                                      ? "Please enter a valid name"
                                      : val.length > 20
                                          ? "Please enter characters less than 20."
                                          : null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              backButton(context),
                              nextButton(() => getName(context)),
                            ],
                          ),
                        ],
                      )
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
