part of 'getlistuser_bloc.dart';

abstract class GetListUserState extends Equatable {
  const GetListUserState();
  @override
  List<Object> get props => [];
}

class GetListUserLoading extends GetListUserState {}

class GetListUserSuccess extends GetListUserState {
  final List<UserDTO> listDTO;
  const GetListUserSuccess(this.listDTO);
  @override
  List<Object> get props => [listDTO];
}

class GetListUserError extends GetListUserState {}
