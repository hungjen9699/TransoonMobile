import 'dart:convert';
import 'dart:io';
import 'package:fluttertransoon/dtos/languageDTO.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../util/flutter_constants.dart';
import '../dtos/languageDTO.dart';

class LanguageRepository {
  static final LanguageRepository _documentRepository =
      LanguageRepository._internal();
  factory LanguageRepository() {
    return _documentRepository;
  }
  LanguageRepository._internal();
  Future<List<LanguageDTO>> fetchLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    final languageListAPIUrl = LANGUAGE_URL;
    print(jwtToken);
    final response = await http.get(languageListAPIUrl, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return parseLanguage(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load language from API');
    }
  }

  List<LanguageDTO> parseLanguage(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<LanguageDTO>((json) => LanguageDTO.fromJson(json))
        .toList();
  }
}
