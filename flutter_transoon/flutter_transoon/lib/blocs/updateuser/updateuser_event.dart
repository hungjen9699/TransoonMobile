part of 'updateuser_bloc.dart';

abstract class UpdateUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUser extends UpdateUserEvent {}
