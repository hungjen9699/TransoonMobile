import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertransoon/blocs/notification/getnotification_bloc.dart';
import 'package:fluttertransoon/dtos/notificationDTO.dart';
import 'package:fluttertransoon/screens/login/components/notificationpage/noti_box.dart';

// ignore: must_be_immutable
class NotificationPage1 extends StatelessWidget {
  NotificationPage1({Key key})
      : assert(true),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetNotificationBloc _getNoti = GetNotificationBloc();
    _getNoti.add(GetNotification());
    return BlocProvider(
      create: (context) => _getNoti,
      child: BlocBuilder<GetNotificationBloc, GetNotificationState>(
        builder: (context, state) {
          if (state is GetNotificationLoading) {
            return Container();
          } else if (state is GetNotificationSuccess) {
            return Container(child: _buildListUser(state.listDTO));
          } else
            return Container();
        },
      ),
    );
  }

  Widget _buildListUser(List<NotificationDTO> listNoti) {
    return SingleChildScrollView(
        child: Container(
            height: 500,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  NotificationDTO dto = listNoti[index];
                  return NotificationBox(
                    dto: dto,
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                  );
                },
                itemCount: listNoti.length)));
  }
}
