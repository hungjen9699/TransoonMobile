part of 'getnotification_bloc.dart';

abstract class GetNotificationState extends Equatable {
  const GetNotificationState();
  @override
  List<Object> get props => [];
}

class GetNotificationLoading extends GetNotificationState {}

class GetNotificationSuccess extends GetNotificationState {
  final List<NotificationDTO> listDTO;
  const GetNotificationSuccess(this.listDTO);
  @override
  List<Object> get props => [listDTO];
}

class GetNotificationError extends GetNotificationState {}
