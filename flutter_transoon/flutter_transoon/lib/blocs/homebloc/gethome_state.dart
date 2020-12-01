part of 'gethome_bloc.dart';

abstract class GetHomeState extends Equatable {
  const GetHomeState();
  @override
  List<Object> get props => [];
}

class GetHomeLoading extends GetHomeState {}

class GetHomeSuccess extends GetHomeState {
  final UserDTO dto;
  final int total;
  final int transooning;
  final int transooned;
  final int requested;
  const GetHomeSuccess(
    this.dto,
    this.total,
    this.transooning,
    this.transooned,
    this.requested,
  );
  @override
  List<Object> get props => [dto, total, transooning, transooned, requested];
}

class GetUserError extends GetHomeState {}
