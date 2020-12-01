import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertransoon/screens/account_tab/account_component/favorite_box.dart';
import 'package:fluttertransoon/screens/account_tab/account_component/title.dart';

class ViewTransooner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("View transooner"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FavoriteBox(),
            TitleTab(
              name: "Primary Language",
              icon: Icons.account_circle,
            ),
            Container(
              margin:
                  EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 20,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.height / 30,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/vietnamese.jpg')),
                    ),
                  ),
                  Container(
                    child: Text("Vietnamese", textAlign: TextAlign.center),
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6)),
                border: Border.all(color: const Color(0xff7e7e7e), width: 1),
              ),
            ),
            TitleTab(
              name: "Major",
              icon: Icons.subject,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 20,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 40),
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 20,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child:
                              Text("Technology", textAlign: TextAlign.center),
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 40,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      border:
                          Border.all(color: const Color(0xff7e7e7e), width: 1),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 20,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child:
                              Text("Technology", textAlign: TextAlign.center),
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 40,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      border:
                          Border.all(color: const Color(0xff7e7e7e), width: 1),
                    ),
                  ),
                ],
              ),
            ),
            TitleTab(
              name: "Feedback",
              icon: Icons.feedback,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height / 20,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child:
                        Text("Say something....", textAlign: TextAlign.center),
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6)),
                border: Border.all(color: const Color(0xff7e7e7e), width: 1),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height / 20,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child:
                        Text("Say something....", textAlign: TextAlign.center),
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6)),
                border: Border.all(color: const Color(0xff7e7e7e), width: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
