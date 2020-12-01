import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class AccountBalanceHome extends StatelessWidget {
  final String balance;
  AccountBalanceHome(this.balance);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 20),
      width: MediaQuery.of(context).size.width - 100,
      height: MediaQuery.of(context).size.height / 11,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: const Color(0xff006ce6)),
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: MediaQuery.of(context).size.height / 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Icon(
              Icons.mail,
              color: Colors.white,
              size: 30,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
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
                    fontSize: 18),
                textAlign: TextAlign.center),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 5),
            width: MediaQuery.of(context).size.width / 3,
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
                    fontWeight: FontWeight.w600,
                    fontFamily: "SVN-ProductSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 19),
                textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}
