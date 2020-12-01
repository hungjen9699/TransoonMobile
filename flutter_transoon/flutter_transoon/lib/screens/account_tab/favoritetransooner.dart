import 'package:flutter/material.dart';
import 'package:fluttertransoon/screens/account_tab/account_component/favorite_box.dart';

class FavoriteTransooner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Favorite Transooner"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FavoriteBox(),
            FavoriteBox(),
            FavoriteBox(),
            FavoriteBox(),
          ],
        ),
      ),
    );
  }
}
