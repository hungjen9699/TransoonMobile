import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertransoon/dtos/transactionDTO.dart';
import 'package:fluttertransoon/dtos/userDTO.dart';
import 'package:fluttertransoon/repositories/document_repository.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/home.dart';

class TransoonerBoxPick extends StatefulWidget {
  final String displayName;
  final UserRepository userRepository;
  final UserDTO dto;
  final TransactionInfoCreateRequestToTransooner transactionDTO;
  TransoonerBoxPick({
    Key key,
    this.displayName,
    this.userRepository,
    this.dto,
    this.transactionDTO,
  }) : super(key: key);
  State<TransoonerBoxPick> createState() => TransoonerBoxPickState();
}

class TransoonerBoxPickState extends State<TransoonerBoxPick> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: const Color(0xff7e7e7e), width: 1),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/avatar.jpg')),
                    color: Colors.redAccent,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.55,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 25,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text("${widget.dto.fullName}",
                            style: const TextStyle(
                                color: const Color(0xff454545),
                                fontWeight: FontWeight.w700,
                                fontFamily: "SVN-ProductSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 12),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10, left: 25),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: widget.dto.email != null
                                    ? Text("${widget.dto.email}",
                                        style: const TextStyle(
                                            color: const Color(0xff454545),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SVN-ProductSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12),
                                        textAlign: TextAlign.left)
                                    : Text(""),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.blue),
                              ),
                              margin: EdgeInsets.only(left: 25),
                              width: MediaQuery.of(context).size.width / 4.5,
                              height: MediaQuery.of(context).size.height / 22,
                              child: RaisedButton(
                                onPressed: () async {
                                  DocumentRepository docRepo =
                                      new DocumentRepository();
                                  bool check =
                                      await docRepo.requestToTransooner(
                                          widget.transactionDTO,
                                          widget.dto.userId);
                                  if (check) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)), //this right here
                                            child: Container(
                                              height: 200,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextField(
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Feedback success!!'),
                                                    ),
                                                    SizedBox(
                                                      width: 320.0,
                                                      child: RaisedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          HomeAuthentication(
                                                                            userRepository:
                                                                                widget.userRepository,
                                                                            displayName:
                                                                                widget.displayName,
                                                                          )));
                                                        },
                                                        child: Text(
                                                          "Back to Home",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        color: const Color(
                                                            0xFF1BC0C5),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                },
                                child: Text(
                                  "Select",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
