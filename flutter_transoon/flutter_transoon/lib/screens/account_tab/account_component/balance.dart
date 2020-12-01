import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class AccountBalance extends StatelessWidget {
  final String balance;
  AccountBalance(this.balance);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: const Color(0xff006ce6)),
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
            height: MediaQuery.of(context).size.height / 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Icon(
              Icons.mail,
              color: Colors.white,
              size: 40,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 22),
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.height / 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text("Balance",
                style: const TextStyle(
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w400,
                    fontFamily: "SVN-ProductSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 20),
                textAlign: TextAlign.center),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 23),
            width: MediaQuery.of(context).size.width / 2.3,
            height: MediaQuery.of(context).size.height / 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(
                FlutterMoneyFormatter(amount: double.parse(balance))
                        .output
                        .withoutFractionDigits +
                    " VND",
                style: const TextStyle(
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w500,
                    fontFamily: "SVN-ProductSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 22),
                textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}
