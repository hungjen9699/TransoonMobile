import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
  final String displayName;
  final String email;
  AccountInfo(this.displayName, this.email);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: const Color(0xff7e7e7e), width: 0.3),
          color: const Color(0xffffffff)),
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 6,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('assets/avatar.jpg')),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  topLeft: Radius.circular(18)),
              color: Colors.redAccent,
            ),
          ),
          Container(
              child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Text(displayName,
                    style: const TextStyle(
                        color: const Color(0xff454545),
                        fontWeight: FontWeight.w700,
                        fontFamily: "SVN-ProductSans",
                        fontSize: 18),
                    textAlign: TextAlign.left),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  children: <Widget>[
                    Text(email,
                        style: const TextStyle(
                            color: const Color(0xff454545),
                            fontFamily: "SVN-ProductSans",
                            fontSize: 12),
                        textAlign: TextAlign.justify),
                    Text("0948-876-076      ",
                        style: const TextStyle(
                            color: const Color(0xff454545),
                            fontFamily: "SVN-ProductSans",
                            fontSize: 12),
                        textAlign: TextAlign.justify),
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
