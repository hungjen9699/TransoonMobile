import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class GetDayTimePicker extends StatefulWidget {
   String dueDate="";
   String time;
   final String deadline;
   final GlobalKey<FormState> formKey;
   GetDayTimePicker({Key key, this.formKey, this.deadline}) : super(key: key);
  @override
  DayTimePicker createState() => DayTimePicker();
}
class DayTimePicker extends State<GetDayTimePicker> {
  final dateFormat = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("HH:mm");
  var timeField = TextEditingController();
  var dueDateField = TextEditingController();
  @override
  void initState() {
    if(widget.deadline!=null){
      dueDateField.text=widget.deadline.split("T").first;
      timeField.text=widget.deadline.split("T").last;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(top: 15,bottom: 20),
            child: Row(
              children: <Widget>[
                //Due Date
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  margin: EdgeInsets.only(left: 25),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 5),
                        child: Text("Due date",
                            style: const TextStyle(
                                color: const Color(0xff393939),
                                fontWeight: FontWeight.w400,
                                fontFamily: "SVN-ProductSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 16),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 17,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: const Color(0xff7a7a7a), width: 0.3),
                            color: const Color(0xffffffff)),
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: DateTimeField(
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only( bottom: 11, top: 11, right: 15),
                                hintText: 'Input date'
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please input date';
                              }
                              var now = DateTime.now();
                              if(value.isBefore(now)){
                                return 'Time cant before now';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                color: const Color(0xff7a7a7a),
                                fontWeight: FontWeight.w400,
                                fontFamily: "SVN-ProductSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 15),
                            format: dateFormat,
                            controller: dueDateField,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            },
                            onChanged: (date) {
                              setState(() {
                                widget.formKey.currentState.validate();
                              });
                              if(date!=null){
                                widget.dueDate = DateFormat("yyyy-MM-dd").format(date);
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //Time
                Container(

                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 65),
                        child: Text("Time",
                            style: const TextStyle(
                                color: const Color(0xff393939),
                                fontWeight: FontWeight.w400,
                                fontFamily: "SVN-ProductSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 16),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height / 17,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: const Color(0xff7a7a7a), width: 0.3),
                              color: const Color(0xffffffff)),
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            child: DateTimeField(
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only( bottom: 11, top: 11, right: 15),
                                  hintText: 'Input time'
                              ),
                              format: timeFormat,
                              controller: timeField,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please input time';
                                }
                                return null;
                              },
                              onShowPicker: (context, currentValue) async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                return DateTimeField.convert(time);
                              },
                              onChanged: (time) {
                                setState(() {
                                  widget.formKey.currentState.validate();
                                });
                                if(time!=null){
                                  widget.time = DateFormat("HH:mm").format(time);
                                }
                              },
                            ),

                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
