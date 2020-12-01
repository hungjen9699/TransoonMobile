import 'package:fluttertransoon/dtos/transactionDTO.dart';
import 'package:fluttertransoon/screens/account_tab/account_component/opacity_line.dart';
import 'package:flutter/material.dart';
import 'package:fluttertransoon/screens/login/components/documentpage/doc_view_content.dart';
import 'package:fluttertransoon/screens/login/components/documentpage/doc_view_title.dart';

class TransactionView extends StatefulWidget {
  final TransactionInfoCreateRequestToTransooner transactionDTO;
  TransactionView({
    Key key,
    this.transactionDTO,
  }) : super(key: key);
  State<TransactionView> createState() => TransactionViewState();
}

class TransactionViewState extends State<TransactionView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DocumentViewWidget(
      transaction: widget.transactionDTO,
    );
  }
}

class DocumentViewWidget extends StatelessWidget {
  final TransactionInfoCreateRequestToTransooner transaction;
  const DocumentViewWidget({Key key, this.transaction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request View"),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
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
                        transaction.originalDoc.path.split("/").last,
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
                    content: transaction.deadline.toIso8601String(),
                  )
                : Container(),
            transaction.deadline != null ? OpacityLine() : Container(),
            DocViewTitle(title: "Language"),
            transaction.originalLanguageId != null &&
                    transaction.translatedLanguageId != null
                ? DocViewContent(
                    content:
                        "${transaction.originalLanguageId} > ${transaction.translatedLanguageId}")
                : null,
            OpacityLine(),
            transaction.transoonerId != null
                ? DocViewTitle(title: "Transooner")
                : Container(),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.blue,
        height: 80,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                "Price :",
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "SVN-ProductSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 24),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 90),
              child: Text(
                "${transaction.totalPaid.toString()} VND",
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "SVN-ProductSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
