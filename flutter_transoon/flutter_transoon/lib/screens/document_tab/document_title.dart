import 'package:flutter/material.dart';

class DocTitle extends StatelessWidget {
  final String title;
  DocTitle({Key key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 15, left: 30, bottom: 5),
            width: MediaQuery.of(context).size.width,
            child: Text(title,
                style: const TextStyle(
                    color: const Color(0xff393939),
                    fontWeight: FontWeight.w400,
                    fontFamily: "SVN-ProductSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
                textAlign: TextAlign.left)),
      ],
    ));
  }
}
