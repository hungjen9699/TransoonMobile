import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertransoon/dtos/hashtagDTO.dart';
import 'package:fluttertransoon/dtos/languageDTO.dart';
import 'package:fluttertransoon/repositories/hashtag_repository.dart';
import 'package:fluttertransoon/repositories/language_repository.dart';
part 'gethashtag_event.dart';
part 'gethashtag_state.dart';

class GetHashTagBloc extends Bloc<GetHashTagEvent, GetHashTagState> {
  GetHashTagBloc();
  @override
  GetHashTagState get initialState => GetHashTagLoading();

  @override
  Stream<GetHashTagState> mapEventToState(GetHashTagEvent event) async* {
    if (event is GetHashTag) {
      LanguageRepository _languageRepository = LanguageRepository();
      HashtagRepository _hashTagRepository = new HashtagRepository();
      List<LanguageDTO> listLanguage =
          await _languageRepository.fetchLanguage();
      List<HashtagDTO> listDTO = await _hashTagRepository.fetchHashtag();
      yield* _mapAppStartedToState(listDTO, listLanguage);
    }
  }

  Stream<GetHashTagState> _mapAppStartedToState(
      List<HashtagDTO> listDTO, List<LanguageDTO> listLanguage) async* {
    if (listDTO != null) {
      yield GetHashTagSuccess(listDTO, listLanguage);
    } else {
      yield GetHashTagError();
    }
  }
}
