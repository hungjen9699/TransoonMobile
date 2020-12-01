import 'dart:convert';
import 'package:fluttertransoon/dtos/transactionQueueDTO.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/flutter_constants.dart';
import '../dtos/transactionDTO.dart';

class DocumentRepository {
  static final DocumentRepository _documentRepository =
      DocumentRepository._internal();

  factory DocumentRepository() {
    return _documentRepository;
  }

  DocumentRepository._internal();

  Future<bool> requestPublic(
      TransactionInfoCreateRequestToTransooner dto) async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var stream =
        new http.ByteStream(DelegatingStream.typed(dto.originalDoc.openRead()));
    var length = await dto.originalDoc.length();
    var apiPath = Uri.parse(TRANSACTION_URL);
    var request = new http.MultipartRequest("POST", apiPath);
    request.headers['authorization'] = "Bearer $jwtToken";
    request.headers['contentTypeHeader'] = "application/json";
    var multipartFile = new http.MultipartFile('originalDoc', stream, length,
        filename: basename(dto.originalDoc.path));
    request.files.add(multipartFile);
    request.fields["customerId"] = dto.customerId;
    request.fields["totalPaid"] = dto.totalPaid.toString();
    request.fields["originalLanguageId"] = dto.originalLanguageId.toString();
    request.fields["translatedLanguageId"] =
        dto.translatedLanguageId.toString();
    request.fields["description"] = dto.description;
    request.fields["deadline"] = dto.deadline.toString();
    request.fields["title"] = dto.title;
    dto.hashTags.forEach((element) {
      request.fields["HashTagIds"] = element.hashTagId.toString();
      print(element.hashTagId.toString());
    });
    var response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> requestToTransooner(
      TransactionInfoCreateRequestToTransooner dto, String transoonerId) async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var stream =
        new http.ByteStream(DelegatingStream.typed(dto.originalDoc.openRead()));
    var length = await dto.originalDoc.length();
    var apiPath = Uri.parse(REQUEST_TO_TRANSOONER);
    var request = new http.MultipartRequest("POST", apiPath);
    request.headers['authorization'] = "Bearer $jwtToken";
    request.headers['contentTypeHeader'] = "application/json";
    var multipartFile = new http.MultipartFile('originalDoc', stream, length,
        filename: basename(dto.originalDoc.path));
    request.files.add(multipartFile);
    request.fields["transoonerId"] = transoonerId;
    request.fields["customerId"] = dto.customerId;
    request.fields["totalPaid"] = dto.totalPaid.toString();
    request.fields["originalLanguageId"] = dto.originalLanguageId.toString();
    request.fields["translatedLanguageId"] =
        dto.translatedLanguageId.toString();
    request.fields["description"] = dto.description;
    request.fields["deadline"] = dto.deadline.toString();
    request.fields["title"] = dto.title;
    dto.hashTags.forEach((element) {
      request.fields["HashTagIds"] = element.hashTagId.toString();
      print(element.hashTagId.toString());
    });
    var response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> updateTransaction(
      TransactionInfoCreateRequestToTransooner dto) async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var apiPath = Uri.parse(BASE_URL + "transactions");
    var request = new http.MultipartRequest("PUT", apiPath);
    request.headers['authorization'] = "Bearer $jwtToken";
    request.headers['contentTypeHeader'] = "application/json";
    if (dto.originalDoc != null) {
      var stream = new http.ByteStream(
          DelegatingStream.typed(dto.originalDoc.openRead()));
      var length = await dto.originalDoc.length();
      var multipartFile = new http.MultipartFile('originalDoc', stream, length,
          filename: basename(dto.originalDoc.path));
      request.files.add(multipartFile);
    } else {
      request.files.add(null);
    }
    request.fields["originalLanguageId"] = dto.originalLanguageId.toString();
    request.fields["translatedLanguageId"] =
        dto.translatedLanguageId.toString();
    request.fields["description"] = dto.description;
    request.fields["deadline"] = dto.deadline.toString();
    request.fields["title"] = dto.title;
    dto.hashTags.forEach(
        (element) => request.fields["HashTagIds"] = element.toString());
    var response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<TransactionInfoToUpdate> viewDoc(int transactionId) async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var apiPath = Uri.parse(TRANSACTION_URL + transactionId.toString());
    final response = await http.get(apiPath, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    if (response.statusCode == 200) {
      final responseJson = json.decode(utf8.decode(response.bodyBytes));
      return TransactionInfoToUpdate.fromJson(responseJson);
    } else {
      throw Exception('Failed to load transaction from API');
    }
  }

  Future<List<TransactionDTO>> fetchTransactionData() async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var userId = prefs.get('userId');
    var apiPath = Uri.encodeFull(GET_TRANSACTION_BY_USER_ID + 'user=$userId');
    final response = await http.get(apiPath, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    return parseTransaction(utf8.decode(response.bodyBytes));
  }

  List<TransactionDTO> parseTransaction(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TransactionDTO>((json) => TransactionDTO.fromJson(json))
        .toList();
  }

  Future<List<TransactionDTO>> fetchRequestTransactionData() async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var userId = prefs.get('userId');
    var apiPath = Uri.encodeFull(
        GET_TRANSACTION_BY_USER_ID + 'user=$userId' + '&status=requested');
    final response = await http.get(apiPath, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    return parseTransaction(utf8.decode(response.bodyBytes));
  }

  Future<List<TransactionDTO>> fetchTransooningTransactionData() async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var userId = prefs.get('userId');
    var apiPath = Uri.encodeFull(
        GET_TRANSACTION_BY_USER_ID + 'user=$userId' + '&status=transooning');
    final response = await http.get(apiPath, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    return parseTransaction(utf8.decode(response.bodyBytes));
  }

  Future<List<TransactionDTO>> fetchWaitingForFeedbackTransactionData() async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var userId = prefs.get('userId');
    var apiPath = Uri.encodeFull(GET_TRANSACTION_BY_USER_ID +
        'user=$userId' +
        '&status=wait-for-feedback');
    final response = await http.get(apiPath, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    return parseTransaction(utf8.decode(response.bodyBytes));
  }

  Future<File> downloadDoc(int transactionId) async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var apiPath =
        Uri.parse(TRANSACTION_URL + "download?id=" + transactionId.toString());
    final response = await http.get(apiPath, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to down file from API');
    }
  }

  Future<bool> customerCancelDoc(int transactionId) async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var apiPath = Uri.parse(TRANSACTION_URL + "customer-cancel-doc");
    final response = await http.put(apiPath,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $jwtToken"
        },
        body: json.encode(transactionId));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to cancel transaction from API');
    }
  }

  Future<bool> feedBackTransooner(
      int transactionId, String feedback, int rating) async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    print(transactionId.toString());
    final response = await http.put(FEED_BACK,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $jwtToken"
        },
        body: jsonEncode(<String, Object>{
          'TransactionId': transactionId,
          'FeedBack': feedback,
          'Rating': rating
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to feedback from API');
    }
  }

  Future<bool> customerAcceptDoc(int transactionQueueId) async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var apiPath = Uri.parse(TRANSACTION_URL + "customer-accepted-doc");
    final response = await http.put(apiPath,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $jwtToken"
        },
        body: json.encode(transactionQueueId));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to accept transaction from API');
    }
  }

  Future<bool> customerDeselectedDoc(int transactionQueueId) async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var apiPath = Uri.parse(TRANSACTION_URL + "customer-accepted-doc");
    final response = await http.put(apiPath,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $jwtToken"
        },
        body: json.encode(transactionQueueId));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to cancel transaction from API');
    }
  }

  Future<List<TransactionQueueDTO>> fetchTransactionQueueData(
      int transactionId) async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var apiPath = Uri.encodeFull(TRANSACTION_QUEUE_ID + 'id=$transactionId');
    final response = await http.get(apiPath.toString(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    return parseTransactionQueue(utf8.decode(response.bodyBytes));
  }

  List<TransactionQueueDTO> parseTransactionQueue(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TransactionQueueDTO>((json) => TransactionQueueDTO.fromJson(json))
        .toList();
  }
}
