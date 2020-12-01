part of 'getlanguage_bloc.dart';

abstract class GetLanguageState extends Equatable {
  const GetLanguageState();
  @override
  List<Object> get props => [];
}

class GetLanguageLoading extends GetLanguageState {}

class GetLanguageSuccess extends GetLanguageState {
  final List<LanguageDTO> listDto;
  const GetLanguageSuccess(this.listDto);
  @override
  List<Object> get props => [listDto];
}

class GetLanguageError extends GetLanguageState {}
