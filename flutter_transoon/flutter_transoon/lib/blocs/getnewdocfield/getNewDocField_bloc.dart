import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertransoon/dtos/hashtagDTO.dart';
import 'package:fluttertransoon/dtos/languageDTO.dart';
import 'package:fluttertransoon/repositories/hashtag_repository.dart';
import 'package:fluttertransoon/repositories/language_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'getNewDocField_event.dart';
part 'getNewDocField_state.dart';

class GetNewDocFieldBloc
    extends Bloc<GetNewDocFieldEvent, GetNewDocFieldState> {
  GetNewDocFieldBloc();
  @override
  GetNewDocFieldState get initialState => GetNewDocFieldLoading();
  @override
  Stream<GetNewDocFieldState> mapEventToState(
      GetNewDocFieldEvent event) async* {
    if (event is GetNewDocField) {
      final prefs = await SharedPreferences.getInstance();
      var userId = prefs.get('userId');
      LanguageRepository _languageRepository = LanguageRepository();
      HashtagRepository _hashTagRepository = new HashtagRepository();
      List<LanguageDTO> listLanguage =
          await _languageRepository.fetchLanguage();
      List<HashtagDTO> listDTO = await _hashTagRepository.fetchHashtag();
      yield* _mapAppStartedToState(listDTO, listLanguage, userId);
    }
  }

  Stream<GetNewDocFieldState> _mapAppStartedToState(
      List<HashtagDTO> listHashTag,
      List<LanguageDTO> listLanguage,
      String userId) async* {
    if (listHashTag != null) {
      yield GetNewDocFieldSuccess(listHashTag, listLanguage, userId);
    } else {
      yield GetNewDocFieldError();
    }
  }
}
