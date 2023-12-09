import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Candidate.dart';

class AuthServices {
  static bool isCandidate = true;
  static Seeker? user;

  static setIsCandidate() async {
    final prefs = await SharedPreferences.getInstance();
    isCandidate = prefs.getBool("isCandidate") ?? true;
  }

  static String get baseUrl {
    if (isCandidate) {
      return _userUrl;
    } else {
      return _companyUrl;
    }
  }

  static const String _userUrl = "http://192.168.9.49:5000/api/v1/user/";
  static const String _companyUrl = "http://192.168.9.49:5000/api/v1/company/";

  static Future<bool> login(
      String email, String password, BuildContext context) async {
    bool isSuccessful = false;
    try {
      print(baseUrl);
      final url = Uri.parse("${baseUrl}login");

      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"email": email, "password": password}));
      print(response.body);

      final responseBody = jsonDecode(response.body);
      final accessToken = responseBody["token"];

      user = Seeker(
        userId: responseBody["user"]['_id'],
        email: responseBody["user"]['email'],
        name: responseBody["user"]['name'],
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", accessToken);


      if (response.statusCode == 200) {
        isSuccessful = true;
      }
    } on HttpException {
      isSuccessful = false;
    } catch (e) {
      isSuccessful = false;
    }
    return isSuccessful;
  }

  static Future<bool> register(
    String email,
    String password,
    String name,
    String resume,
    BuildContext context,
  ) async {
    bool isSuccessful = false;
    try {
      final url = Uri.parse("${baseUrl}register");
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: isCandidate?jsonEncode({
            "email": email,
            "password": password,
            "name": name,
            "resume": resume
          }):jsonEncode({
            "email": email,
            "password": password,
            "name": name,
          }));
      print(response.body);
      final responseBody = jsonDecode(response.body);
      final accessToken = responseBody["token"];
      user = Seeker(
        userId: responseBody["user"]['_id'],
        email: responseBody["user"]['email'],
        name: responseBody["user"]['name'],
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", accessToken);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        isSuccessful = true;
      }
    } on HttpException {
      isSuccessful = false;
    } catch (e) {
      isSuccessful = false;
    }
    return isSuccessful;
  }
}
