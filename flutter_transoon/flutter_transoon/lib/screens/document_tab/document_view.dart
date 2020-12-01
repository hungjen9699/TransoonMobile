import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertransoon/blocs/transaction/gettransactionbyid/getTransactionById_bloc.dart';
import 'package:fluttertransoon/dtos/transactionDTO.dart';
import 'package:fluttertransoon/repositories/document_repository.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/account_tab/account_component/opacity_line.dart';
import 'package:flutter/material.dart';
import 'package:fluttertransoon/screens/document_tab/document_component/viewdocbutton.dart';
import 'package:fluttertransoon/screens/document_tab/view_list_choosen_transooner.dart';
import 'package:fluttertransoon/screens/home.dart';
import 'package:fluttertransoon/screens/login/components/documentpage/doc_view_content.dart';
import 'package:fluttertransoon/screens/login/components/documentpage/doc_view_title.dart';
import 'package:fluttertransoon/screens/transooner_loader_scafford.dart';
import 'package:quick_feedback/quick_feedback.dart';

class DocumentView extends StatefulWidget {
  final int type;
  final int transactionIndex;
  final String displayName;
  final UserRepository userRepository;
  DocumentView(
      {Key key,
      this.transactionIndex,
      this.displayName,
      this.userRepository,
      this.type})
      : super(key: key);
  State<DocumentView> createState() => DocumentViewState();
}

class DocumentViewState extends State<DocumentView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    print(widget.transactionIndex);
    // ignore: close_sinks
    GetTransactionByIdBloc _getViewField =
        GetTransactionByIdBloc(widget.transactionIndex);
    _getViewField.add(GetTransactionById());
    return BlocProvider(
      create: (context) => _getViewField,
      child: BlocBuilder<GetTransactionByIdBloc, GetTransactionByIdState>(
        builder: (context, state) {
          if (state is GetTransactionByIdLoading) {
            return TransoonLoaderScafford();
          } else if (state is GetTransactionByIdSuccess) {
            return new DocumentViewWidget(
              transaction: state.dto,
              displayName: widget.displayName,
              userRepository: widget.userRepository,
              type: widget.type,
            );
          } else
            return Container();
        },
      ),
    );
  }
}

class DocumentViewWidget extends StatelessWidget {
  final int type;
  final TransactionInfoToUpdate transaction;
  final String displayName;
  final UserRepository userRepository;
  const DocumentViewWidget(
      {Key key,
      this.transaction,
      this.displayName,
      this.userRepository,
      this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Document"),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
          child: Container(
        height: 700,
        child: Column(
          children: <Widget>[
            transaction.title != null
                ? DocViewTitle(title: "Title")
                : Container(),
            transaction.title != null
                ? DocViewContent(content: transaction.title)
                : Container(),
            transaction.title != null ? OpacityLine() : Container(),
            transaction.description != null
                ? DocViewTitle(title: "Description")
                : Container(),
            transaction.description != null
                ? DocViewContent(content: transaction.description)
                : Container(),
            transaction.description != null ? OpacityLine() : Container(),
            transaction.hashTags.length > 0
                ? DocViewTitle(title: "Hashtag")
                : Container(),
            transaction.hashTags.length > 0
                ? DocViewContent(content: transaction.hashTags[0].tagName)
                : Container(),
            transaction.hashTags.length > 0 ? OpacityLine() : Container(),
            transaction.originalDoc != null
                ? DocViewTitle(title: "File")
                : Container(),
            transaction.originalDoc != null
                ? Container(
                    margin: EdgeInsets.only(right: 150),
                    width: 150,
                    child: RaisedButton(
                      color: Colors.black38,
                      onPressed: () {},
                      child: Text(
                        transaction.originalDoc,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Container(),
            transaction.originalDoc != null ? OpacityLine() : Container(),
            transaction.deadline != null
                ? DocViewTitle(title: "Deadline")
                : Container(),
            transaction.deadline != null
                ? DocViewContent(
                    content: transaction.deadline,
                  )
                : Container(),
            transaction.deadline != null ? OpacityLine() : Container(),
            DocViewTitle(title: "Language"),
            transaction.originalLanguageName != null &&
                    transaction.translatedLanguageName != null
                ? DocViewContent(
                    content:
                        "${transaction.originalLanguageName} > ${transaction.translatedLanguageName}")
                : null,
            OpacityLine(),
            transaction.transoonerId != null
                ? DocViewTitle(title: "Transooner")
                : Container(),
            transaction.transoonerId != null
                ? DocViewContent(
                    content: transaction.transoonerId,
                  )
                : Container(),
            type == 1
                ? RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewListChosenTransooner(
                                    userRepository: userRepository,
                                    displayName: displayName,
                                    transactionIndex: transaction.transactionId,
                                  )));
                    },
                    child: Text(
                      "View List Transooner",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: const Color(0xFF1BC0C5),
                  )
                : Container(),
            type == 2 && transaction.status == "wait-for-feedback"
                ? RaisedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return QuickFeedback(
                            title: 'Leave a feedback', // Title of dialog
                            showTextBox: true, // default false
                            textBoxHint:
                                'Share your feedback', // Feedback text field hint text default: Tell us more
                            submitText:
                                'SUBMIT', // submit button text default: SUBMIT
                            onSubmitCallback: (feedback) async {
                              FeedBack tmp = FeedBack.fromJson(feedback);
                              DocumentRepository docRepo = DocumentRepository();
                              bool check = await docRepo.feedBackTransooner(
                                  transaction.transactionId,
                                  tmp.feedback,
                                  tmp.rating);
                              if (check) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0)), //this right here
                                        child: Container(
                                          height: 200,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextField(
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
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
                                                              builder: (context) =>
                                                                  HomeAuthentication(
                                                                    userRepository:
                                                                        userRepository,
                                                                    displayName:
                                                                        displayName,
                                                                  )));
                                                    },
                                                    child: Text(
                                                      "Back to Home",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    color:
                                                        const Color(0xFF1BC0C5),
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
                            askLaterText: 'ASK LATER',
                            onAskLaterCallback: () {
                              print('Do something on ask later click');
                            },
                          );
                        },
                      );
                    },
                    child: Text(
                      "Feedback",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: const Color(0xFF1BC0C5),
                  )
                : Container(),
          ],
        ),
      )),
      bottomSheet: Container(
          color: Colors.black87,
          height: 120,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 30, bottom: 5),
                      child: Text(
                        "Price :",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "SVN-ProductSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 25),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 118, bottom: 5),
                      child: Text(
                        "${transaction.totalPaid.toString()} VND",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "SVN-ProductSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    type != 3
                        ? ViewDocButton(
                            type: type,
                            displayName: displayName,
                            userRepository: userRepository,
                            transaction: transaction,
                            fontColor: Colors.black87,
                            backColor: Colors.white,
                            content: "Cancel Request",
                            pushToEdit: false,
                          )
                        : Container(),
                    type != 3
                        ? ViewDocButton(
                            type: type,
                            displayName: displayName,
                            userRepository: userRepository,
                            transaction: transaction,
                            fontColor: Colors.white,
                            backColor: Colors.blue,
                            content: "Edit Document",
                            pushToEdit: true,
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class FeedBack {
  final int rating;
  final String feedback;

  FeedBack({
    this.rating,
    this.feedback,
  });

  FeedBack.fromJson(Map json)
      : rating = json['rating'],
        feedback = json['feedback'];
}
