part of 'newdocument_bloc.dart';

abstract class NewdocumentState extends Equatable {
  const NewdocumentState();

  @override
  List<Object> get props => [];
}

class NewdocumentUninitial extends NewdocumentState {}

class NewdocumentInProgress extends NewdocumentState {}

class NewdocumentFailure extends NewdocumentState {
  final String error;
  const NewdocumentFailure({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'NewdocumentFailure { error: $error }';
}

class NewdocumentSuccess extends NewdocumentState {}
