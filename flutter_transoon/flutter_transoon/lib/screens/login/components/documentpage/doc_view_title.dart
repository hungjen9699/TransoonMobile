import 'package:flutter/material.dart';

class DocViewTitle extends StatelessWidget {
  final String title;

  DocViewTitle({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 15, left: 30),
            width: MediaQuery.of(context).size.width,
            child: Text(title,
                style: const TextStyle(
                    color: const Color(0xff393939),
                    fontWeight: FontWeight.w700,
                    fontFamily: "SVN-ProductSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 17),
                textAlign: TextAlign.left)),
      ],
    ));
  }
}
