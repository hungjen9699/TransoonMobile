import 'package:flutter/material.dart';

class NotificationBox extends StatelessWidget {
  final String title;
  final String messageInfo;
  NotificationBox(this.title, this.messageInfo);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.mail,
                  color: Colors.blue,
                  size: 40,
                ),
                width: MediaQuery.of(context).size.width / 10,
                decoration: BoxDecoration()),
            Container(
              height: MediaQuery.of(context).size.height / 10,
              margin: EdgeInsets.only(),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 40),
                    child: Text(title,
                        style: const TextStyle(
                            color: const Color(0xff454545),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 14),
                        textAlign: TextAlign.justify),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6, right: 80),
                    child: Text(messageInfo,
                        style: const TextStyle(
                            color: const Color(0xff454545),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 12),
                        textAlign: TextAlign.left),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6, right: 170),
                    child: Text(
                      "Jun 06 2020, 07:30 PM",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: const Color(0xff7e7e7e), width: 1),
            color: const Color(0xffffffff)));
  }
}
