import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DocumentNewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      icon: Icon(
        FontAwesomeIcons.google,
        color: Colors.red,
      ),
      onPressed: () {},
      label: Text('New', style: TextStyle(color: Colors.grey)),
      color: Colors.white,
    );
  }
}
