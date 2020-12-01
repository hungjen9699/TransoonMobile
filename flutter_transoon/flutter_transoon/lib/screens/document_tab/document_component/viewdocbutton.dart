import 'package:flutter/material.dart';
import 'package:fluttertransoon/dtos/transactionDTO.dart';
import 'package:fluttertransoon/repositories/document_repository.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import '../../home.dart';
import '../document_edit.dart';

class ViewDocButton extends StatelessWidget {
  final int type;
  final TransactionInfoToUpdate transaction;
  final String displayName;
  final UserRepository userRepository;
  final Color fontColor;
  final Color backColor;
  final String content;
  final bool pushToEdit;
  const ViewDocButton({
    Key key,
    this.transaction,
    this.displayName,
    this.userRepository,
    this.type,
    this.fontColor,
    this.backColor,
    this.content,
    this.pushToEdit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 30),
        child: RaisedButton(
          color: backColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.only(left: 20, right: 20),
          onPressed: () {
            if (pushToEdit) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DocumentEdit(
                            transactionInfoToUpdate: transaction,
                          )));
            } else
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 200,
                      width: 300.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: Text(
                              'Do you really want to cancel this request?',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                RaisedButton(
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  onPressed: () async {
                                    DocumentRepository docRepo =
                                        DocumentRepository();
                                    bool check =
                                        await docRepo.customerCancelDoc(
                                            transaction.transactionId);
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
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextField(
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Cancel request success!!'),
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
                                                                              userRepository: userRepository,
                                                                              displayName: displayName,
                                                                            )));
                                                          },
                                                          child: Text(
                                                            "Back to Home",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
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
                                    'Okay',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                RaisedButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel!',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.blue),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
          },
          child: Text(
            content,
            style: TextStyle(color: fontColor),
          ),
        ));
  }
}
