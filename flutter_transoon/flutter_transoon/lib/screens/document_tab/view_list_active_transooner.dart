import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertransoon/blocs/getlistuser/getlistuser_bloc.dart';
import 'package:fluttertransoon/dtos/transactionDTO.dart';
import 'package:fluttertransoon/dtos/userDTO.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/document_tab/document_component/transoonerboxpick.dart';

class ViewListActiveTransooner extends StatefulWidget {
  final String displayName;
  final UserRepository userRepository;
  final TransactionInfoCreateRequestToTransooner transactionDTO;
  ViewListActiveTransooner({
    Key key,
    this.displayName,
    this.userRepository,
    this.transactionDTO,
  }) : super(key: key);
  State<ViewListActiveTransooner> createState() =>
      ViewListActiveTransoonerState();
}

class ViewListActiveTransoonerState extends State<ViewListActiveTransooner> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetListUserBloc _getListUser = GetListUserBloc();
    _getListUser.add(GetListActiveTransooner());
    return BlocProvider(
      create: (context) => _getListUser,
      child: BlocBuilder<GetListUserBloc, GetListUserState>(
        builder: (context, state) {
          if (state is GetListUserLoading) {
            return Container();
          } else if (state is GetListUserSuccess) {
            return ViewListPickTransoonerWidget(
              displayName: widget.displayName,
              userRepository: widget.userRepository,
              transactionDTO: widget.transactionDTO,
              listDTO: state.listDTO,
            );
          } else
            return Container();
        },
      ),
    );
  }
}

class ViewListPickTransoonerWidget extends StatelessWidget {
  final String displayName;
  final UserRepository userRepository;
  final List<UserDTO> listDTO;
  final TransactionInfoCreateRequestToTransooner transactionDTO;
  ViewListPickTransoonerWidget(
      {Key key,
      this.displayName,
      this.userRepository,
      this.listDTO,
      this.transactionDTO})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List Transooner Choose Doc"),
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              UserDTO dto = listDTO[index];
              return TransoonerBoxPick(
                transactionDTO: transactionDTO,
                userRepository: userRepository,
                displayName: displayName,
                dto: dto,
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 15,
              );
            },
            itemCount: listDTO.length));
  }
}
