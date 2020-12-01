import 'package:flutter/material.dart';
import 'package:fluttertransoon/screens/login/components/transactionpage/trans_title.dart';

class TransactionDetailPaid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Detail"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, left: 30),
              child: TransTitle(title: "Payment"),
            ),
            //box
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 8,
              margin: EdgeInsets.only(top: 10, left: 25, right: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: const Color(0xff7e7e7e), width: 1),
                  color: const Color(0xffffffff)),
              child: Row(
                children: <Widget>[
                  //left
                  Container(
                      margin: EdgeInsets.only(bottom: 45, left: 10),
                      child: Text("Your fare",
                          style: const TextStyle(
                              color: const Color(0xff7a7a7a),
                              fontWeight: FontWeight.w400,
                              fontFamily: "SVN-ProductSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 15),
                          textAlign: TextAlign.left)),
                  //right
                  Container(
                    //vnd
                    margin: EdgeInsets.only(top: 5, left: 65),
                    child: Text("VND",
                        style: const TextStyle(
                            color: const Color(0xff707070),
                            fontWeight: FontWeight.w700,
                            fontFamily: "SVN-ProductSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10),
                        textAlign: TextAlign.center),
                  ),
                  //point
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 10),
                    child: Text("1.789.000",
                        style: const TextStyle(
                            color: const Color(0xff707070),
                            fontWeight: FontWeight.w700,
                            fontFamily: "SVN-ProductSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 25),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60, left: 30),
              child: Column(
                children: <Widget>[
                  TransTitle(title: "Paid to"),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text("Do Huu Phat",
                          style: const TextStyle(
                              color: const Color(0xff393939),
                              fontWeight: FontWeight.w900,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 15),
                          textAlign: TextAlign.left)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60, left: 30),
              child: Column(
                children: <Widget>[
                  TransTitle(title: "Transooned doc"),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text("This is America in June 2020",
                          style: const TextStyle(
                              color: const Color(0xff393939),
                              fontWeight: FontWeight.w900,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 15),
                          textAlign: TextAlign.left)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60, left: 30),
              child: Column(
                children: <Widget>[
                  TransTitle(title: "Date and time"),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text("07 June 2020, 07:30PM",
                          style: const TextStyle(
                              color: const Color(0xff393939),
                              fontWeight: FontWeight.w900,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 15),
                          textAlign: TextAlign.left)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
