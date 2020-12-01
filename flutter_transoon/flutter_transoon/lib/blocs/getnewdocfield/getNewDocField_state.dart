part of 'getNewDocField_bloc.dart';

abstract class GetNewDocFieldState extends Equatable {
  const GetNewDocFieldState();
  @override
  List<Object> get props => [];
}

class GetNewDocFieldLoading extends GetNewDocFieldState {}

class GetNewDocFieldSuccess extends GetNewDocFieldState {
  final List<HashtagDTO> listHashTag;
  final List<LanguageDTO> listLanguage;
  final String userId;
  const GetNewDocFieldSuccess(this.listHashTag, this.listLanguage, this.userId);
  @override
  List<Object> get props => [listHashTag, listLanguage, userId];
}

class GetNewDocFieldComplete extends GetNewDocFieldState {}

class GetNewDocFieldError extends GetNewDocFieldState {}
