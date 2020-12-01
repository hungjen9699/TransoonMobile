import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertransoon/blocs/gettransactionqueue/gettransactionqueue_bloc.dart';
import 'package:fluttertransoon/dtos/transactionQueueDTO.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/document_tab/document_component/transoonerbox.dart';
import 'package:fluttertransoon/screens/transooner_loader_scafford.dart';

class ViewListChosenTransooner extends StatefulWidget {
  final int transactionIndex;
  final String displayName;
  final UserRepository userRepository;
  ViewListChosenTransooner({
    Key key,
    this.transactionIndex,
    this.displayName,
    this.userRepository,
  }) : super(key: key);
  State<ViewListChosenTransooner> createState() =>
      ViewListChosenTransoonerState();
}

class ViewListChosenTransoonerState extends State<ViewListChosenTransooner> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetTransactionQueueBloc _getViewField =
        GetTransactionQueueBloc(widget.transactionIndex);
    _getViewField.add(GetTransactionQueue());
    return BlocProvider(
      create: (context) => _getViewField,
      child: BlocBuilder<GetTransactionQueueBloc, GetTransactionQueueState>(
        builder: (context, state) {
          if (state is GetTransactionQueueLoading) {
            return TransoonLoaderScafford();
          } else if (state is GetTransactionQueueSuccess) {
            return new ViewListChosenTransoonerWidget(
              displayName: widget.displayName,
              userRepository: widget.userRepository,
              transactionIndex: widget.transactionIndex,
              listDTO: state.listDTO,
            );
          } else
            return Container();
        },
      ),
    );
  }
}

class ViewListChosenTransoonerWidget extends StatelessWidget {
  final int type;
  final int transactionIndex;
  final String displayName;
  final UserRepository userRepository;
  final List<TransactionQueueDTO> listDTO;
  ViewListChosenTransoonerWidget(
      {Key key,
      this.transactionIndex,
      this.displayName,
      this.userRepository,
      this.type,
      this.listDTO})
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
              TransactionQueueDTO dto = listDTO[index];
              return TransoonerBox(
                transactionIndex: dto.transactionId,
                displayName: displayName,
                userRepository: userRepository,
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
