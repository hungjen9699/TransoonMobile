part of 'updateuser_bloc.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();
  @override
  List<Object> get props => [];
}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final UserDTO dto;
  const UpdateUserSuccess(this.dto);
  @override
  List<Object> get props => [dto];
}

class UpdateUserError extends UpdateUserState {}
