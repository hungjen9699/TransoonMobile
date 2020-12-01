import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertransoon/dtos/languageDTO.dart';
import 'package:fluttertransoon/repositories/language_repository.dart';
part 'getlanguage_event.dart';
part 'getlanguage_state.dart';

class GetLanguageBloc extends Bloc<GetLanguageEvent, GetLanguageState> {
  GetLanguageBloc();
  @override
  GetLanguageState get initialState => GetLanguageLoading();
  @override
  Stream<GetLanguageState> mapEventToState(GetLanguageEvent event) async* {
    if (event is GetLanguage) {
      LanguageRepository _languageRepository = new LanguageRepository();
      List<LanguageDTO> listDTO = await _languageRepository.fetchLanguage();
      yield* _mapAppStartedToState(listDTO);
    }
  }

  Stream<GetLanguageState> _mapAppStartedToState(
      List<LanguageDTO> listDTO) async* {
    if (listDTO != null) {
      yield GetLanguageSuccess(listDTO);
    } else {
      yield GetLanguageError();
    }
  }
}
