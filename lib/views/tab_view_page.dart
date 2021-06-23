import 'package:dailytodo/views/calendar_page.dart';
import 'package:dailytodo/views/challenge_page.dart';
import 'package:dailytodo/views/home.dart';
import 'package:dailytodo/views/info_page.dart';
import 'package:dailytodo/views/timeline_page.dart';
import 'package:dailytodo/views/todo_list_page.dart';
import 'package:dailytodo/views/trello_page.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TabViewPage extends StatelessWidget {
  static const id = '/tabview';

  final String _formattedTime =
      DateFormat('EEEE, d MMMM').format(DateTime.now());
  final String displayName;

  TabViewPage(this.displayName);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          primary: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(135),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.06),
              flexibleSpace: Padding(
                padding: EdgeInsets.only(
                  left: 22,
                  right: 22,
                  top: 15,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "$_formattedTime\n",
                            style: kHintTextFieldTextStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: "Hey, $displayName",
                            style: kIntroTextStyle.copyWith(
                                fontSize: 22, height: 1.6),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.info,
                        size: 20,
                        color: Colors.grey[700],
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => InfoPage(
                            isInfo: true,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(CupertinoIcons.square_stack_3d_up),
                      onPressed: () =>
                          Navigator.pushNamed(context, TodoListPage.id),
                    )
                  ],
                ),
              ),
              bottom: TabBar(
                indicatorColor: kaccentColor,
                tabs: [
                  Tab(icon: Icon(CupertinoIcons.rocket)),
                  Tab(icon: Icon(CupertinoIcons.timer)),
                  Tab(icon: Icon(CupertinoIcons.calendar)),
                  Tab(icon: Icon(CupertinoIcons.loop)),
                ],
              ),
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              TimelinePage(),
              CalendarPage(),
              ChallengePage(),
            ],
          ),
        ),
      ),
    );
  }
}
