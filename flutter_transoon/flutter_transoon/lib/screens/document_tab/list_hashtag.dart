import 'package:flutter/material.dart';
import 'package:fluttertransoon/dtos/hashtagDTO.dart';

// ignore: must_be_immutable
class GetHashTagList extends StatefulWidget {
  final List<HashtagDTO> listDTO;
  HashtagDTO selectedValue;
  GetHashTagList({Key key, this.listDTO}) : super(key: key);
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<GetHashTagList> {
  List<HashtagDTO> get items => widget.listDTO;
  int index = 0;
  @override
  void initState() {
    widget.selectedValue = items[0];
    super.initState();
    widget.selectedValue = items[index];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10, top: 5),
        child: Row(
          children: <Widget>[
            DropdownButton<HashtagDTO>(
              value: items == null ? null : items[index],
              onChanged: (value) {
                setState(() {
                  index = items.indexOf(value);
                  widget.selectedValue = value;
                });
              },
              selectedItemBuilder: (BuildContext context) {
                return items.map<Widget>((HashtagDTO item) {
                  return Text(item.tagName);
                }).toList();
              },
              items: items.map((HashtagDTO item) {
                return DropdownMenuItem<HashtagDTO>(
                  child: Text(item.tagName),
                  value: item,
                );
              }).toList(),
            ),
          ],
        ));
  }
}
