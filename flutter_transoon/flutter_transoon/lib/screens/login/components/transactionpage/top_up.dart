import 'package:flutter/material.dart';
import 'package:fluttertransoon/screens/login/components/transactionpage/trans_title.dart';

class TopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top up"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, left: 30),
              child: TransTitle(title: "Top-up value"),
            ),
            //box
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 12,
              margin: EdgeInsets.only(top: 10, left: 25, right: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: const Color(0xff7e7e7e), width: 1),
                  color: const Color(0xffffffff)),
              child: Row(
                children: <Widget>[
                  //left
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text("1.000.000",
                          style: const TextStyle(
                              color: const Color(0xff7a7a7a),
                              fontWeight: FontWeight.w400,
                              fontFamily: "SVN-ProductSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 20),
                          textAlign: TextAlign.left)),
                  //right
                  Container(
                    //vnd
                    margin: EdgeInsets.only(left: 150),
                    child: Text("VND",
                        style: const TextStyle(
                            color: const Color(0xff707070),
                            fontWeight: FontWeight.w400,
                            fontFamily: "SVN-ProductSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 20),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
