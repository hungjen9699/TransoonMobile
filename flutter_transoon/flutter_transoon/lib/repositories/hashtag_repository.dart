import 'dart:convert';
import 'dart:io';
import 'package:fluttertransoon/dtos/hashtagDTO.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../util/flutter_constants.dart';
import '../dtos/hashtagDTO.dart';

class HashtagRepository {
  static final HashtagRepository _documentRepository =
      HashtagRepository._internal();

  factory HashtagRepository() {
    return _documentRepository;
  }

  HashtagRepository._internal();
  Future<List<HashtagDTO>> fetchHashtag() async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    print(jwtToken);
    final hashtagListAPIUrl = HASH_TAG_URL;
    final response = await http.get(hashtagListAPIUrl, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse
          .map((hashtagDTO) => new HashtagDTO.fromJson(hashtagDTO))
          .toList();
    } else {
      throw Exception('Failed to load hashtag from API');
    }
  }
}
