import 'package:flutter/material.dart';

class DocViewContent extends StatelessWidget {
  final String content;

  DocViewContent({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10, left: 30,bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: Text(content,
                    style: const TextStyle(
                        color: const Color(0xff393939),
                        fontFamily: "SVN-ProductSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 12),
                    textAlign: TextAlign.left)),
          ],
        ));
  }
}
