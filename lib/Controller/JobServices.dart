import 'dart:convert';

import 'package:make_a_million/Controller/AuthServices.dart';
import 'package:http/http.dart' as http;

class JobServices{

static const String baseUrl = "http://192.168.9.49:5000/api/v1/opening/";
  static Future<bool> addJobRole(String name, String description,List<String> applicants)async{
    final url = Uri.parse("$baseUrl${AuthServices.user!.userId}/new");
    final response = await http.post(url,body: jsonEncode({
      "role":name,
      "description":description,
      "applicants":applicants
    }),headers: {
      "Content-Type": "application/json",

    });
    print(response.body);
    if(response.statusCode == 200 || response.statusCode == 201){
      return true;
    }else{
      return false;
    }

  }
  static Future<bool> getJobRole()async{
    final url = Uri.parse("$baseUrl${AuthServices.user!.userId}/get");
}