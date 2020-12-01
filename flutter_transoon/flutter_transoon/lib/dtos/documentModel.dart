import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../util/flutter_constants.dart';

Future<DocDTO> fetchDocument() async {
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.get('userId');
  var jwtToken = prefs.get('jwtToken');
  final response = await http.get(USER_URL + userId, headers: {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: "Bearer $jwtToken"
  });
  print("Response" + response.body);
  final responseJson = json.decode(response.body);
  return DocDTO.fromJson(responseJson);
}

class DocDTO {
  final String docId;
  final String title;
  final String firstLanguage;
  final String secondLanguage;
  final DateTime createDate;
  final int price;
  final String description;
  DocDTO._(
      {this.docId,
      this.title,
      this.firstLanguage,
      this.secondLanguage,
      this.createDate,
      this.price,
      this.description});
  factory DocDTO.fromJson(Map<String, dynamic> json) {
    return new DocDTO._(
      docId: json['docId'],
      title: json['title'],
      firstLanguage: json['firstLanguage'],
      secondLanguage: json['secondLanguage'],
      createDate: json['createDate'],
      price: json['price'],
      description: json['description'],
    );
  }
}
