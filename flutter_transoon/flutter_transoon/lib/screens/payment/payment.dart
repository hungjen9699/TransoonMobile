import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:fluttertransoon/blocs/payment/getpayment_bloc.dart';
import 'package:fluttertransoon/dtos/paymentDTO.dart';
import 'package:fluttertransoon/screens/login/components/accountpage/account_balance_for_payment.dart';
import 'package:fluttertransoon/screens/transooner_loader_scafford.dart';

// ignore: must_be_immutable
class Payment extends StatelessWidget {
  final int accountBalance;
  Payment({Key key, this.accountBalance})
      : assert(true),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetPaymentBloc _getPayment = GetPaymentBloc();
    _getPayment.add(GetPayment());
    return BlocProvider(
      create: (context) => _getPayment,
      child: BlocBuilder<GetPaymentBloc, GetPaymentState>(
        builder: (context, state) {
          if (state is GetPaymentLoading) {
            return TransoonLoaderScafford();
          } else if (state is GetPaymentSuccess) {
            return _buildListPayment(state.listDTO);
          } else
            return Container();
        },
      ),
    );
  }

  Widget _buildListPayment(List<PaymentDTO> listPayment) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top up"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            AccountBalancePayment(accountBalance.toString()),
            Container(
                margin: EdgeInsets.only(left: 30),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.rotate_left),
                    Text(
                      "Transaction History",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ],
                )),
            Container(
              child: SingleChildScrollView(
                  child: Container(
                      height: 470,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            PaymentDTO dto = listPayment[index];
                            return Container(
                              width: 300,
                              height: 50,
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      color: const Color(0xff7a7a7a),
                                      width: 0.3),
                                  color: const Color(0xffffffff)),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: dto.paymentType ==
                                                          'Paid' ||
                                                      dto.paymentType == 'Done'
                                                  ? 120
                                                  : dto.paymentType ==
                                                          'SendBack'
                                                      ? 84
                                                      : 40,
                                              top: 5),
                                          child: Text(
                                            dto.paymentType,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 30, top: 5),
                                          child: Text(
                                              dto.createdDate.split(".").first,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12)),
                                        )
                                      ],
                                    ),
                                    width: 180,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                          FlutterMoneyFormatter(
                                                      amount:
                                                          dto.credit.toDouble())
                                                  .output
                                                  .withoutFractionDigits +
                                              " VND",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18)))
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1,
                            );
                          },
                          itemCount: listPayment.length))),
            ),
          ],
        ),
      ),
    );
  }
}
