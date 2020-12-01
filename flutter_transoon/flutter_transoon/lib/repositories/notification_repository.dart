import 'dart:convert';
import 'package:fluttertransoon/dtos/notificationDTO.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../util/flutter_constants.dart';

class NotificationRepository {
  static final NotificationRepository _notificationRepository =
      NotificationRepository._internal();

  factory NotificationRepository() {
    return _notificationRepository;
  }

  NotificationRepository._internal();
  Future<List<NotificationDTO>> fetchNotificaion() async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var apiPath = Uri.encodeFull(GET_NOTIFICATION);
    final response = await http.get(apiPath.toString(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    return parseNotification(utf8.decode(response.bodyBytes));
  }

  List<NotificationDTO> parseNotification(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<NotificationDTO>((json) => NotificationDTO.fromJson(json))
        .toList();
  }
}
