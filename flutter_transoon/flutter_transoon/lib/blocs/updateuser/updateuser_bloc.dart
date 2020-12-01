import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertransoon/dtos/userDTO.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import '../../repositories/user_repository.dart';
part 'updateuser_event.dart';
part 'updateuser_state.dart';

class GetUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UserRepository _userRepository;
  GetUserBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  UpdateUserState get initialState => UpdateUserLoading();
  @override
  Stream<UpdateUserState> mapEventToState(UpdateUserEvent event) async* {
    // if you have multiple event
    if (event is GetUser) {
      final dto = await _userRepository.fetchUserInfo();
      yield* _mapAppStartedToState(dto);
    }
  }

  Stream<UpdateUserState> _mapAppStartedToState(UserDTO dto) async* {
    if (dto != null) {
      yield UpdateUserSuccess(dto);
    } else {
      yield UpdateUserError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
