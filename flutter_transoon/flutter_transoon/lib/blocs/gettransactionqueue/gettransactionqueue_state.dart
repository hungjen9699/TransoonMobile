part of 'gettransactionqueue_bloc.dart';

abstract class GetTransactionQueueState extends Equatable {
  const GetTransactionQueueState();
  @override
  List<Object> get props => [];
}

class GetTransactionQueueLoading extends GetTransactionQueueState {}

class GetTransactionQueueSuccess extends GetTransactionQueueState {
  final List<TransactionQueueDTO> listDTO;
  const GetTransactionQueueSuccess(this.listDTO);
  @override
  List<Object> get props => [listDTO];
}

class GetTransactionQueueError extends GetTransactionQueueState {}
