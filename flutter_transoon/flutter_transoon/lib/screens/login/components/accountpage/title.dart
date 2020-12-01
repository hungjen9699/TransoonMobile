import 'package:flutter/material.dart';

class TitleTab extends StatelessWidget {
  final IconData icon;
  final String name;

  TitleTab({Key key, @required this.name, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 10,  bottom: 5),
      width: MediaQuery.of(context).size.width,
      height: 30,
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 30,
            child: Icon(
              icon,
              size: 20,
            ),
          ),
          Text(name,
              style: const TextStyle(
                  color: const Color(0xff454545),
                  fontWeight: FontWeight.w400,
                  fontFamily: "SVN-ProductSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 15.0),
              textAlign: TextAlign.left)
        ],
      ),
    );
  }
}
