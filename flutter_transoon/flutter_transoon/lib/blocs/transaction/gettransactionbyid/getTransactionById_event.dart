part of 'getTransactionById_bloc.dart';

abstract class GetTransactionByIdEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTransactionById extends GetTransactionByIdEvent {}
