import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertransoon/blocs/getuser/getuser_bloc.dart';
import 'package:fluttertransoon/dtos/transactionQueueDTO.dart';
import 'package:fluttertransoon/dtos/userDTO.dart';
import 'package:fluttertransoon/repositories/document_repository.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/home.dart';

class TransoonerBox extends StatefulWidget {
  final int transactionIndex;
  final String displayName;
  final UserRepository userRepository;
  final TransactionQueueDTO dto;
  TransoonerBox({
    Key key,
    this.transactionIndex,
    this.displayName,
    this.userRepository,
    this.dto,
  }) : super(key: key);
  State<TransoonerBox> createState() => TransoonerBoxState();
}

class TransoonerBoxState extends State<TransoonerBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetUserBloc _getUser =
        GetUserBloc(widget.dto.transoonerId, widget.userRepository);
    _getUser.add(GetUserById());
    return BlocProvider(
      create: (context) => _getUser,
      child: BlocBuilder<GetUserBloc, GetUserState>(
        builder: (context, state) {
          if (state is GetUserLoading) {
            return Container();
          } else if (state is GetUserSuccess) {
            return new TransoonerBoxWidget(
                displayName: widget.displayName,
                userRepository: widget.userRepository,
                tranDTO: widget.dto,
                transoonerDTO: state.dto,
                transactionIndex: widget.transactionIndex);
          } else
            return Container();
        },
      ),
    );
  }
}

class TransoonerBoxWidget extends StatelessWidget {
  final int transactionIndex;
  final String displayName;
  final UserRepository userRepository;
  final TransactionQueueDTO tranDTO;
  final UserDTO transoonerDTO;

  TransoonerBoxWidget({
    Key key,
    this.transactionIndex,
    this.displayName,
    this.userRepository,
    this.tranDTO,
    this.transoonerDTO,
  }) : super(key: key);
  @override
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
                        child: Text("${transoonerDTO.fullName}",
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
                                child: transoonerDTO.email != null
                                    ? Text("${transoonerDTO.email}",
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
                                  bool check = await docRepo.customerAcceptDoc(
                                      tranDTO.transactionQueueId);
                                  if (check) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeAuthentication(
                                                  userRepository:
                                                      userRepository,
                                                  displayName: displayName,
                                                )));
                                  }
                                },
                                child: Text(
                                  "Select",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              width: MediaQuery.of(context).size.width / 4.5,
                              height: MediaQuery.of(context).size.height / 22,
                              child: RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  "Reject",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue,
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
