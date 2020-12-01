import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertransoon/dtos/userDTO.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
part 'getlistuser_event.dart';
part 'getlistuser_state.dart';

class GetListUserBloc extends Bloc<GetListUserEvent, GetListUserState> {
  @override
  GetListUserState get initialState => GetListUserLoading();

  @override
  Stream<GetListUserState> mapEventToState(GetListUserEvent event) async* {
    UserRepository _userRepository = new UserRepository();
    if (event is GetListActiveTransooner) {
      List<UserDTO> listDTO = await _userRepository.fetchListActiveTransooner();

      yield* _mapAppStartedToState(listDTO);
    }
  }

  Stream<GetListUserState> _mapAppStartedToState(List<UserDTO> listDTO) async* {
    if (listDTO != null) {
      yield GetListUserSuccess(listDTO);
      close();
    } else {
      yield GetListUserError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
