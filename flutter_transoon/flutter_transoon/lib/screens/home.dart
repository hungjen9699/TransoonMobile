import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/home_tab/home_tab.dart';
import 'package:fluttertransoon/screens/notification_tab/notificationpage.dart';
import 'document_tab/document.dart';
import 'account_tab/account.dart';

class HomeAuthentication extends StatefulWidget {
  final UserRepository _userRepository;
  final String displayName;
  HomeAuthentication(
      {Key key, @required UserRepository userRepository, this.displayName})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HomeAuthenticationState();
  }
}

class HomeAuthenticationState extends State<HomeAuthentication> {
  UserRepository get _userRepository => widget._userRepository;
  String get displayName => widget.displayName;
  int _selectedTab = 0;
  List<String> appBarTitle = ["Home", "Document", "Message", "Account"];
  Widget selectTab(int selectedIndex) {
    if (selectedIndex == 0) {
      return HomeTabPage(
        userRepository: widget._userRepository,
        displayName: widget.displayName,
      );
    }
    if (selectedIndex == 1) {
      return DocumentPage(
        userRepository: _userRepository,
        displayName: displayName,
      );
    } else if (selectedIndex == 2) {
      return NotificationPage1();
    } else {
      return AccountPage(
        userRepository: _userRepository,
        displayName: displayName,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          )),
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(appBarTitle[_selectedTab]),
            backgroundColor: Colors.blue[700],
          ),
          body: SingleChildScrollView(child: selectTab(_selectedTab)),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: _selectedTab,
            showElevation: true, // use this to remove appBar's elevation
            onItemSelected: (index) => setState(() {
              _selectedTab = index;
            }),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Colors.blue,
              ),
              BottomNavyBarItem(
                  icon: Icon(Icons.event_note),
                  title: Text('Document'),
                  activeColor: Colors.blue),
              BottomNavyBarItem(
                  icon: Icon(Icons.message),
                  title: Text('Messages'),
                  activeColor: Colors.blue),
              BottomNavyBarItem(
                  icon: Icon(Icons.account_circle),
                  title: Text('Account'),
                  activeColor: Colors.blue),
            ],
          )),
    );
  }
}
