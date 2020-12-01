import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertransoon/dtos/loginDTO.dart';
import 'package:fluttertransoon/dtos/userDTO.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../util/flutter_constants.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();
  Future<LoginDTO> loginUserApi(String idToken, String fcmToken) async {
    final http.Response response = await http.post(
      CUSTOMER_AUTHENTICATE,
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'idToken': idToken,
        'fcmToken': fcmToken,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.body);
      return LoginDTO.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<UserDTO> fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('userId');
    var jwtToken = prefs.get('jwtToken');
    print(userId);
    String apiPath = USER_URL + userId;
    final response = await http.get(apiPath, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    final responseJson = json.decode(utf8.decode(response.bodyBytes));
    return UserDTO.fromJson(responseJson);
  }

  Future<UserDTO> fetchUserInfoById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    print(jwtToken);
    String apiPath = USER_URL + id;
    final response = await http.get(apiPath, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    final responseJson = json.decode(utf8.decode(response.bodyBytes));
    return UserDTO.fromJson(responseJson);
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    FirebaseMessaging fm = new FirebaseMessaging();
    String fcmToken = await fm.getToken();
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    var user = await _firebaseAuth.currentUser();
    user.getIdToken().then((token) {
      setDataAfterLogin(token.token, fcmToken);
    });
    return _firebaseAuth.currentUser();
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  Future<FirebaseUser> getFirebaseUser() async {
    return await _firebaseAuth.currentUser();
  }

  setJWTToken(String jwtToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('jwtToken', jwtToken);
  }

  setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId);
  }

  Future<String> getJWTToken() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('jwtToken');
    return value;
  }

  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('userId');
    return value;
  }

  setDataAfterLogin(String idToken, String fcmToken) async {
    LoginDTO dto = await loginUserApi(idToken, fcmToken);
    print("haha" + dto.userId);
    setUserId(dto.userId);
    setJWTToken(dto.jwtToken);
  }

  Future<bool> updateBasicInfo(UserInfoUpdate dto) async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var userId = prefs.get("userId");
    var apiPath = Uri.parse(USER_URL + userId + "/basic");
    final response = await http.post(
      apiPath.toString(),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $jwtToken"
      },
      body: jsonEncode(<String, String>{
        'Fullname': dto.fullName,
        'PhoneNumber': dto.phoneNumber,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update user info from API');
    }
  }

  Future<List<UserDTO>> fetchListActiveTransooner() async {
    final prefs = await SharedPreferences.getInstance();
    var jwtToken = prefs.get('jwtToken');
    var apiPath = Uri.encodeFull(GET_LIST_ACTIVE_TRANSOONER);
    print(apiPath);
    final response = await http.get(apiPath.toString(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $jwtToken"
    });
    return parseTransooner(utf8.decode(response.bodyBytes));
  }

  List<UserDTO> parseTransooner(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<UserDTO>((json) => UserDTO.fromJson(json)).toList();
  }
}
