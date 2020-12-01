part of 'gettransaction_bloc.dart';

abstract class GetTransactionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllTransaction extends GetTransactionEvent {}

class GetRequestTransaction extends GetTransactionEvent {}

class GetTransooningTransaction extends GetTransactionEvent {}
