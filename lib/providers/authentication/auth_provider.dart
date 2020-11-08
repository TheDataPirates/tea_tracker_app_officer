import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _user_id;

  String get user_id => _user_id;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> login(String userId, String password) async {
    logout();
    const url = 'http://10.0.2.2:8080/auth/login';
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{"user_id": userId, "password": password},
        ),
      );
      final responseData = jsonDecode(response.body);

      print(response.statusCode);
      print(responseData['token']);
      if (response.statusCode == 400) {
        throw Exception(responseData['message']);
      }
      _token = responseData['token'];

//       String expiry =JwtDecoder.getExpirationDate(_token);
      _expiryDate = JwtDecoder.getExpirationDate(_token);
      print(_expiryDate);
      _user_id = responseData['userId'];

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode(
        {
          'token': _token,
          'userId': _user_id,
          'expiryDate': _expiryDate.toIso8601String()
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        jsonDecode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _user_id = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
//    Duration tokenTime = JwtDecoder.getTokenTime(_token);
//    print(tokenTime.inSeconds);
    print('pressed logout');
    _token = null;
    _user_id = null;
    _expiryDate = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
