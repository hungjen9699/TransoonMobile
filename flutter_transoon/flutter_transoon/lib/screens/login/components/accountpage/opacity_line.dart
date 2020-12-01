import 'package:flutter/material.dart';

class OpacityLine extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.501960813999176,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffb7b7b7),
                width: 0.5,
              ))),
    );
  }
}
