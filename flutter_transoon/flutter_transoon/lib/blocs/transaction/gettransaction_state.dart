part of 'gettransaction_bloc.dart';

abstract class GetTransactionState extends Equatable {
  const GetTransactionState();
  @override
  List<Object> get props => [];
}

class GetTransactionLoading extends GetTransactionState {}

class GetTransactionSuccess extends GetTransactionState {
  final List<TransactionDTO> listDto;
  const GetTransactionSuccess(this.listDto);
  @override
  List<Object> get props => [listDto];
}

class GetTransactionError extends GetTransactionState {}
