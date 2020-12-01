import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertransoon/dtos/userDTO.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import '../../repositories/user_repository.dart';
part 'getuser_event.dart';
part 'getuser_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  final UserRepository _userRepository;
  final String id;
  GetUserBloc(this.id, this._userRepository);

  @override
  GetUserState get initialState => GetUserLoading();
  @override
  Stream<GetUserState> mapEventToState(GetUserEvent event) async* {
    // if you have multiple event
    if (event is GetUser) {
      final dto = await _userRepository.fetchUserInfo();
      yield* _mapAppStartedToState(dto);
    } else if (event is GetUserById) {
      print(id);
      final dto = await _userRepository.fetchUserInfoById(id);
      yield* _mapAppStartedToState(dto);
    }
  }

  Stream<GetUserState> _mapAppStartedToState(UserDTO dto) async* {
    if (dto != null) {
      yield GetUserSuccess(dto);
    } else {
      yield GetUserError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
