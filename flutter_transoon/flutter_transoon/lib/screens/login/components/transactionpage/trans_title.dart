import 'package:flutter/material.dart';

class TransTitle extends StatelessWidget {
  final String title;

  TransTitle({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            child: Text(title,
                style: const TextStyle(
                    color: const Color(0xff393939),
                    fontWeight: FontWeight.w400,
                    fontFamily: "SVN-ProductSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 17),
                textAlign: TextAlign.left)),
      ],
    ));
  }
}
