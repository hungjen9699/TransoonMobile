part of 'gethashtag_bloc.dart';

abstract class GetHashTagState extends Equatable {
  const GetHashTagState();
  @override
  List<Object> get props => [];
}

class GetHashTagLoading extends GetHashTagState {}

class GetHashTagSuccess extends GetHashTagState {
  final List<HashtagDTO> listDto;
  final List<LanguageDTO> listLanguage;
  const GetHashTagSuccess(this.listDto, this.listLanguage);
  @override
  List<Object> get props => [listDto];
}

class GetHashTagComplete extends GetHashTagState {}

class GetHashTagError extends GetHashTagState {}
