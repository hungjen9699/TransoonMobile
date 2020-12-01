import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertransoon/dtos/transactionDTO.dart';
import 'package:fluttertransoon/dtos/userDTO.dart';
import 'package:fluttertransoon/repositories/document_repository.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import '../../repositories/user_repository.dart';
part 'gethome_event.dart';
part 'gethome_state.dart';

class GetHomeBloc extends Bloc<GetHomeEvent, GetHomeState> {
  final UserRepository _userRepository;
  GetHomeBloc(this._userRepository);

  @override
  GetHomeState get initialState => GetHomeLoading();
  @override
  Stream<GetHomeState> mapEventToState(GetHomeEvent event) async* {
    // if you have multiple event
    if (event is GetHome) {
      final dto = await _userRepository.fetchUserInfo();
      DocumentRepository documentRepository = DocumentRepository();
      List<TransactionDTO> listDTO =
          await documentRepository.fetchTransactionData();
      int total = listDTO.length;
      int transooning = 0;
      int transooned = 0;
      int requested = 0;
      if (listDTO != null) {
        listDTO.forEach((element) {
          if (element.status == 'transooning' ||
              element.status == 'wait-for-feedback') {
            transooning += 1;
          } else if (element.status == "completed") {
            transooned += 1;
          } else if (element.status == "requested") {
            requested += 1;
          }
        });
      }

      yield* _mapAppStartedToState(
          dto, total, transooning, transooned, requested);
    }
  }

  Stream<GetHomeState> _mapAppStartedToState(UserDTO dto, int total,
      int transooning, int transooned, int requested) async* {
    if (dto != null) {
      yield GetHomeSuccess(dto, total, transooning, transooned, requested);
    } else {
      yield GetUserError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
