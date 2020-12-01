part of 'getTransactionById_bloc.dart';

abstract class GetTransactionByIdState extends Equatable {
  const GetTransactionByIdState();
  @override
  List<Object> get props => [];
}

class GetTransactionByIdLoading extends GetTransactionByIdState {}

class GetTransactionByIdSuccess extends GetTransactionByIdState {
  final TransactionInfoToUpdate dto;
  const GetTransactionByIdSuccess(this.dto);
  @override
  List<Object> get props => [dto];
}

class GetTransactionByIdError extends GetTransactionByIdState {}
