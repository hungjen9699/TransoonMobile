import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertransoon/blocs/homebloc/gethome_bloc.dart';
import 'package:fluttertransoon/dtos/userDTO.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/account_tab/account_component/opacity_line.dart';
import 'package:fluttertransoon/screens/account_tab/favoritetransooner.dart';
import 'package:fluttertransoon/screens/document_tab/document_new_app.dart';
import 'package:fluttertransoon/screens/login/components/accountpage/account_balance_for_home.dart';
import 'package:fluttertransoon/screens/payment/payment.dart';
import 'package:fluttertransoon/screens/transoon_loader.dart';

// ignore: must_be_immutable
class HomeTabPage extends StatelessWidget {
  final UserRepository _userRepository;
  final String displayName;
  UserDTO dto;

  HomeTabPage(
      {Key key, @required UserRepository userRepository, this.displayName})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetHomeBloc _getHome = GetHomeBloc(_userRepository);
    _getHome.add(GetHome());
    return BlocProvider(
      create: (context) => _getHome,
      child: BlocBuilder<GetHomeBloc, GetHomeState>(
        builder: (context, state) {
          if (state is GetHomeLoading) {
            return TransoonLoader();
          } else if (state is GetHomeSuccess) {
            int other = state.total -
                state.transooned -
                state.requested -
                state.transooning;
            return Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 140,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),

                // Total Doc
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Good morning, ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  "${state.dto.fullName}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )),
                        Container(
                          width: 260,
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 40,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Total docs",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 153),
                                      child: Text(
                                        "${state.total}",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Opacity(
                                opacity: 0.501960813999176,
                                child: Container(
                                    width: 250,
                                    height: 1,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      color: const Color(0xffb7b7b7),
                                      width: 0.5,
                                    ))),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 10),
                                height: 25,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      size: 12,
                                      color: Colors.blue,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Transooning docs",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 90),
                                      child: Text(
                                        "${state.transooning}",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 25,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      size: 12,
                                      color: Colors.green,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Requested docs",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 100),
                                      child: Text(
                                        "${state.requested}",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 25,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      size: 12,
                                      color: Colors.orangeAccent,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Transooned docs",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 93),
                                      child: Text(
                                        "${state.transooned}",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 25,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle,
                                      size: 12,
                                      color: Colors.red,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Others docs",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 120),
                                      child: Text(
                                        "$other",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        AccountBalanceHome(state.dto.balance.toString()),
                        Container(
                          width: 300,
                          height: 120,
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 30),
                                child: Column(
                                  children: <Widget>[
                                    ClipOval(
                                      child: Material(
                                        color:
                                            Colors.deepOrange, // button color
                                        child: InkWell(
                                          splashColor:
                                              Colors.red, // inkwell color
                                          child: SizedBox(
                                              width: 56,
                                              height: 56,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 30,
                                              )),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DocumentNewApp(
                                                          displayName:
                                                              displayName,
                                                          userRepository:
                                                              _userRepository,
                                                        )));
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Create new doc",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 40),
                                child: Column(
                                  children: <Widget>[
                                    ClipOval(
                                      child: Material(
                                        color: Colors.green, // button color
                                        child: InkWell(
                                          splashColor:
                                              Colors.red, // inkwell color
                                          child: SizedBox(
                                              width: 56,
                                              height: 56,
                                              child: Icon(
                                                Icons.attach_money,
                                                color: Colors.white,
                                                size: 30,
                                              )),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Payment(
                                                          accountBalance:
                                                              state.dto.balance,
                                                        )));
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Top up balance",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        OpacityLine(),
                        Container(
                          margin: EdgeInsets.only(right: 130, top: 10),
                          child: Text(
                            "Don't miss this",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 45),
                          height: 100,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image:
                                  new AssetImage("assets/banner-transoon.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 45),
                          height: 100,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image:
                                  new AssetImage("assets/banner-transoon.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            );
          } else
            return FavoriteTransooner();
        },
      ),
    );
  }
}
