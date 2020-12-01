import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertransoon/dtos/notificationDTO.dart';
import 'package:fluttertransoon/repositories/notification_repository.dart';
part 'getnotification_event.dart';
part 'getnotification_state.dart';

class GetNotificationBloc
    extends Bloc<GetNotificationEvent, GetNotificationState> {
  GetNotificationBloc();
  @override
  GetNotificationState get initialState => GetNotificationLoading();

  @override
  Stream<GetNotificationState> mapEventToState(
      GetNotificationEvent event) async* {
    NotificationRepository _notificationRepo = new NotificationRepository();
    if (event is GetNotification) {
      List<NotificationDTO> listDTO =
          await _notificationRepo.fetchNotificaion();
      yield* _mapAppStartedToState(listDTO);
    }
  }

  Stream<GetNotificationState> _mapAppStartedToState(
      List<NotificationDTO> listDTO) async* {
    if (listDTO != null) {
      yield GetNotificationSuccess(listDTO);
      close();
    } else {
      yield GetNotificationError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
