import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/models/timeline.dart';
import 'package:dailytodo/views/add_timeline_page.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/floatingactionButton.dart';
import 'package:dailytodo/widgets/no_todo_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelinePage extends StatelessWidget {
  final formattedString = DateFormat('MMM d');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(
        context: context,
        backgroundColor: kaccentColor,
        icon: CupertinoIcons.calendar_badge_plus,
        location: AddTimeLinePage.id,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: FutureBuilder(
          future: DatabaseService.instance.getTimeLineList(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data.length > 0
                ? ListView.builder(
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 100,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container();
                      }

                      final Timeline timeline = snapshot.data[index - 1];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "${formattedString.format(timeline.dateTime)}\n",
                                          style:
                                              kHintTextFieldTextStyle.copyWith(
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Day ${timeline.day}\n",
                                          style:
                                              kTextFieldHintTextStyle.copyWith(
                                            fontSize: 18,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kcanvasColor,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: GestureDetector(
                                onLongPress: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTimeLinePage(
                                      timeline: timeline,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    left: 10,
                                  ),
                                  decoration: containerDecoration,
                                  padding: EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        timeline.title,
                                        style: kTextFieldHintTextStyle.copyWith(
                                            fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      timeline.des.length <= 0
                                          ? Container()
                                          : Text(
                                              timeline.des,
                                              style: kHintTextFieldTextStyle
                                                  .copyWith(
                                                color: Colors.grey[500],
                                                height: 1.5,
                                                fontSize: 13,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: 1 + snapshot.data.length,
                  )
                : NoTodoWidget(
                    height: getHeight(context),
                    image: "assets/images/timeline.png",
                    ismain: false,
                    title:
                        "No Time line added yet!\nAdd it to make a track of your days.",
                  );
          },
        ),
      ),
    );
  }
}
