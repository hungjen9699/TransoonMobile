import 'package:flutter/material.dart';

class InputFileInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 30),
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              child: Text("File",
                  style: const TextStyle(
                      color: const Color(0xff393939),
                      fontWeight: FontWeight.w400,
                      fontFamily: "SVN-ProductSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 17),
                  textAlign: TextAlign.left)),
          Container(
            width: MediaQuery.of(context).size.width,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  style: const TextStyle(
                      color: const Color(0xff595959),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.italic,
                      fontSize: 10),
                  text: "Allow only specific file type: \ntxt"),
            ])),
          )
        ],
      ),
    );
  }
}
