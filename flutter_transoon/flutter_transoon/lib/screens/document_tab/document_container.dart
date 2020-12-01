import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertransoon/blocs/transaction/gettransaction_bloc.dart';
import 'package:fluttertransoon/dtos/transactionDTO.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/document_tab/document_view.dart';

import '../transoon_loader.dart';

class DocumentContainer extends StatelessWidget {
  final int type;
  final UserRepository userRepository;
  final String displayName;
  const DocumentContainer(
      {Key key, this.type, this.userRepository, this.displayName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetTransactionBloc _getTransaction = GetTransactionBloc();
    print(type);
    if (type == 1) {
      _getTransaction.add(GetRequestTransaction());
    } else if (type == 2) {
      _getTransaction.add(GetTransooningTransaction());
    } else {
      _getTransaction.add(GetAllTransaction());
    }

    return BlocProvider(
      create: (context) => _getTransaction,
      child: BlocBuilder<GetTransactionBloc, GetTransactionState>(
        builder: (context, state) {
          if (state is GetTransactionLoading) {
            return TransoonLoader();
          } else if (state is GetTransactionSuccess) {
            return _buildListUser(state.listDto);
          } else
            return Container();
        },
      ),
    );
  }

  Widget _buildListUser(List<TransactionDTO> transactions) {
    return ListView.separated(
        itemBuilder: (context, index) {
          TransactionDTO dto = transactions[index];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DocumentView(
                              transactionIndex: dto.transactionId,
                              userRepository: userRepository,
                              displayName: displayName,
                              type: type,
                            )));
              },
              child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 4),
                        child: Row(
                          children: <Widget>[
                            dto.hashTags.length > 0
                                ? Text(" #${dto.hashTags[0].tagName}",
                                    style: TextStyle(color: Colors.blue))
                                : Text(""),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(" ${dto.title}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.speaker_notes,
                              size: 16,
                              color: Colors.blue,
                            ),
                            dto.description != null
                                ? Text("  " + dto.description,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black))
                                : Text(""),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.event_note,
                              size: 16,
                              color: Colors.blue,
                            ),
                            Text("  Deadline at ${dto.deadline}",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                  "  ${dto.originalLanguageName} > ${dto.translatedLanguageName}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white)),
                              margin: EdgeInsets.only(right: 60),
                            ),
                            Container(
                              child: Text("${dto.totalPaid}" + " VND",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white)),
                            )
                          ],
                        ),
                        height: MediaQuery.of(context).size.height / 18,
                        decoration: BoxDecoration(
                          color: dto.status == 'canceled'
                              ? Colors.black45
                              : dto.status == 'completed'
                                  ? Colors.deepOrange
                                  : Colors.blue,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6)),
                        ),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.217,
                  margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.black45),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: Colors.white)));
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
          );
        },
        itemCount: transactions.length);
  }
}
