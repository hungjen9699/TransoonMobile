part of 'gettransactionqueue_bloc.dart';

abstract class GetTransactionQueueEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTransactionQueue extends GetTransactionQueueEvent {}
