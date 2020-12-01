part of 'getuser_bloc.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();
  @override
  List<Object> get props => [];
}

class GetUserLoading extends GetUserState {}

class GetUserSuccess extends GetUserState {
  final UserDTO dto;
  const GetUserSuccess(this.dto);
  @override
  List<Object> get props => [dto];
}

class GetUserError extends GetUserState {}
