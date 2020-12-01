part of 'gettransaction_bloc.dart';

abstract class GetTransactionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTransaction extends GetTransactionEvent {}
