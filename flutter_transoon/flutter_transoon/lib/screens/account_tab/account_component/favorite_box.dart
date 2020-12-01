import 'package:flutter/material.dart';
import '../viewtransooner.dart';

class FavoriteBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6,
      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: const Color(0xff7e7e7e), width: 1),
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
                  bottomLeft: Radius.circular(6), topLeft: Radius.circular(6)),
              color: Colors.redAccent,
            ),
          ),
          Container(
              child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Text("Nguyen Quang Huy",
                    style: const TextStyle(
                        color: const Color(0xff454545),
                        fontWeight: FontWeight.w700,
                        fontFamily: "SVN-ProductSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 18),
                    textAlign: TextAlign.left),
              ),
              Container(
                margin: EdgeInsets.only(right: 80, top: 10),
                child: Row(
                  children: <Widget>[
                    Text("EN->VN"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 80, top: 10),
                child: Row(
                  children: <Widget>[
                    Text("3.4"),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 160),
                child: GestureDetector(
                    child: Text("View",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewTransooner()));
                    }),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
