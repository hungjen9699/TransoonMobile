import 'package:flutter/material.dart';
import 'package:fluttertransoon/dtos/languageDTO.dart';

// ignore: must_be_immutable
class GetLanguageList extends StatefulWidget {
  final List<LanguageDTO> listDTO;
  final firstValue;
  LanguageDTO selectedValue;
  GetLanguageList({Key key, this.listDTO, this.firstValue}) : super(key: key);
  @override
  _GetLanguageState createState() => _GetLanguageState();
}

class _GetLanguageState extends State<GetLanguageList> {
  List<LanguageDTO> get items => widget.listDTO;
  int index = 0;
  @override
  void initState() {
    for (var prop in items) {
      if (widget.firstValue == prop.languageName)
        break;
      else
        index = index + 1;
    }
    super.initState();
    widget.selectedValue = items[index];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 10),
        width: MediaQuery.of(context).size.width / 2.7,
        height: MediaQuery.of(context).size.height / 17,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: const Color(0xff7a7a7a), width: 0.3),
            color: const Color(0xffffffff)),
        child: Container(
            margin: EdgeInsets.only(left: 10, top: 5),
            child: Row(
              children: <Widget>[
                DropdownButton<LanguageDTO>(
                  value: items == null ? null : items[index],
                  onChanged: (value) {
                    setState(() {
                      index = items.indexOf(value);
                      widget.selectedValue = value;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return items.map<Widget>((LanguageDTO item) {
                      return Text(item.languageName);
                    }).toList();
                  },
                  items: items.map((LanguageDTO item) {
                    return DropdownMenuItem<LanguageDTO>(
                      child: Text(item.languageName),
                      value: item,
                    );
                  }).toList(),
                ),
              ],
            )));
  }
}
