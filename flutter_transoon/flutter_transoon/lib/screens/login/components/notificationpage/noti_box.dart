import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertransoon/dtos/notificationDTO.dart';

// MyApp is a StatefulWidget. This allows updating the state of the
// widget when an item is removed.
class NotificationBox extends StatefulWidget {
  final NotificationDTO dto;
  NotificationBox({Key key, this.dto}) : super(key: key);

  @override
  State<NotificationBox> createState() => NotificationBoxState();
  }

class NotificationBoxState extends State<NotificationBox> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
      margin: EdgeInsets.only(top: 10,left: 10,right: 10),
        child: Row(children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.mail,
                color: Colors.blue,
                size: 40,
              ),
              width: MediaQuery.of(context).size.width/10,
              decoration: BoxDecoration(
              )),
          Container(
            width: MediaQuery.of(context).size.width-70,
            height: MediaQuery.of(context).size.height/10,
            margin: EdgeInsets.only(),
            child: Column(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width-70,
                margin: EdgeInsets.only(top: 6 ,left: 10),

                  child: new Container(
                    padding: new EdgeInsets.only(right: 13.0),
                    child: new Text(
                      widget.dto.title,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Roboto',
                        color: new Color(0xFF212121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Container(
                width: MediaQuery.of(context).size.width-90,
                margin: EdgeInsets.only(top: 6 ),

                  child: new Container(
                    padding: new EdgeInsets.only(right: 13.0),
                    child: new Text(
                      widget.dto.body,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Roboto',
                        color: new Color(0xFF212121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Container(
                margin: EdgeInsets.only(top: 6,right: 170),
                child: Text(
    widget.dto.createdDate,
                  style: const TextStyle(
                      color:  Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      fontStyle:  FontStyle.normal,
                      fontSize: 10
                  ),
                ),),
            ],),
          ),

        ],),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(8)
            ),
            border: Border.all(
                color: const Color(0xff7e7e7e),
                width: 1
            ),
            color: const Color(0xffffffff)
        )
    );

  }
}
