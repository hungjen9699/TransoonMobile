part of 'getuser_bloc.dart';

abstract class GetUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUser extends GetUserEvent {}

class GetUserById extends GetUserEvent {}
