import 'package:flutter/material.dart';
class AccountBalance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/8,
      margin: EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: const Color(0xff006ce6)),
      child: Row(
        children: <Widget>[
          Container(
              child: Icon(
                Icons.mail,
                color: Colors.white,
                size: 40,
              ),
              width: 60,
              height: MediaQuery.of(context).size.height/10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
          Container(
              margin: EdgeInsets.only(top: 30),
              child: Text("Balance",
                  style: const TextStyle(
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w400,
                      fontFamily: "SVN-ProductSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 20),
                  textAlign: TextAlign.center),
              width: MediaQuery.of(context).size.width/5,
              height: MediaQuery.of(context).size.height/10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
          Container(
              margin: EdgeInsets.only(left: 10, top: 26),
              child: Text("1.888.0000",
                  style: const TextStyle(
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w400,
                      fontFamily: "SVN-ProductSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 28),
                  textAlign: TextAlign.center),
              width: MediaQuery.of(context).size.width/2.5,
              height: MediaQuery.of(context).size.height/10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5))))
        ],
      ),
    );
  }
}