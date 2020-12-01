import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/document_tab/document_container.dart';
import 'package:fluttertransoon/screens/document_tab/document_new_app.dart';

class DocumentPage extends StatefulWidget {
  final UserRepository _userRepository;
  final String displayName;
  DocumentPage(
      {Key key, @required UserRepository userRepository, this.displayName})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DocumentState();
  }
}

class _DocumentState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              constraints: BoxConstraints.expand(height: 60),
              child: TabBar(
                  tabs: [
                    Tab(text: "Requested"),
                    Tab(text: "In Progress"),
                    Tab(text: "Completed"),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BubbleTabIndicator(
                    indicatorHeight: 40,
                    indicatorColor: Colors.orange,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  )),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  Container(
                    child: DocumentContainer(
                      type: 1,
                      userRepository: widget._userRepository,
                      displayName: widget.displayName,
                    ),
                  ),
                  Container(
                    child: DocumentContainer(
                      type: 2,
                      userRepository: widget._userRepository,
                      displayName: widget.displayName,
                    ),
                  ),
                  new Container(
                    child: DocumentContainer(
                      type: 3,
                      userRepository: widget._userRepository,
                      displayName: widget.displayName,
                    ),
                  ),
                ]),
              ),
            ),
            IconButton(
                icon: Icon(Icons.add_circle, size: 40, color: Colors.orange),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DocumentNewApp(
                                displayName: widget.displayName,
                                userRepository: widget._userRepository,
                              )));
                }),
          ],
        ),
      ),
    );
  }
}
