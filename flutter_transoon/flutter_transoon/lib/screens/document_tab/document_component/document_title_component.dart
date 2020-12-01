import 'package:flutter/material.dart';

class DocumentTitleComponent extends StatelessWidget {
  final String title;

  DocumentTitleComponent({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15, left: 30),
        width: MediaQuery.of(context).size.width,
        child: Text(title,
            style: const TextStyle(
                color: const Color(0xff393939),
                fontWeight: FontWeight.w400,
                fontFamily: "SVN-ProductSans",
                fontStyle: FontStyle.normal,
                fontSize: 17),
            textAlign: TextAlign.left));
  }
}
