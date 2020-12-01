import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertransoon/blocs/transaction/gettransaction_bloc.dart';
import 'package:fluttertransoon/screens/account_tab/favoritetransooner.dart';

import 'account_tab/editprofile.dart';

class MyHomePageState extends StatelessWidget {
  MyHomePageState({Key key})
      : assert(true),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetTransactionBloc _getTransaction = GetTransactionBloc();
    _getTransaction.add(GetAllTransaction());
    return BlocProvider(
      create: (context) => _getTransaction,
      child: BlocBuilder<GetTransactionBloc, GetTransactionState>(
        builder: (context, state) {
          if (state is GetTransactionLoading) {
            return EditPro();
          } else if (state is GetTransactionSuccess) {
            return Container(
                child: Text(state.listDto[0].transactionId.toString()));
          } else
            return FavoriteTransooner();
        },
      ),
    );
  }
}
