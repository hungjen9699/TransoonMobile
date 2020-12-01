part of 'gethashtag_bloc.dart';

abstract class GetHashTagEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetHashTag extends GetHashTagEvent {}
