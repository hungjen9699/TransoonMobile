import 'dart:convert';
import 'package:fluttertransoon/dtos/paymentDTO.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../util/flutter_constants.dart';

class PaymentRepository {
  static final PaymentRepository _notificationRepository =
      PaymentRepository._internal();

  factory PaymentRepository() {
    return _notificationRepository;
  }

  PaymentRepository._internal();
  Future<List<PaymentDTO>> fetchPayment() async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var userId = prefs.get('userId');
    var apiPath = Uri.encodeFull(PAYMENT_URL + "?user=$userId");
    final response = await http.get(apiPath.toString(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    return parsePayment(utf8.decode(response.bodyBytes));
  }

  List<PaymentDTO> parsePayment(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<PaymentDTO>((json) => PaymentDTO.fromJson(json)).toList();
  }
}
