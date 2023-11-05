import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:make_a_million/Controller/AuthServices.dart';

class JobServices {
  static const String baseUrl = "http://192.168.9.49:5000/api/v1/opening/";

  static Future<bool> addJobRole(
      String name, String description, List<String> applicants) async {
    final url = Uri.parse("$baseUrl${AuthServices.user!.userId}/new");
    final response = await http.post(url,
        body: jsonEncode({
          "role": name,
          "description": description,
          "applicants": applicants
        }),
        headers: {
          "Content-Type": "application/json",
        });
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
  static Future<List<Map<String, dynamic>>> getCompanyJobs(){
    final url = Uri.parse("$baseUrl/company/${AuthServices.user!.userId}");
    return http.get(url, headers: {
      "Content-Type": "application/json",
    }).then((response) {
      print(response.body);
      final List<Map<String, dynamic>> jobs = [];
      final responseBody = jsonDecode(response.body);
      for (var element in responseBody["openings"]) {
        jobs.add({
          "id": element["_id"],
          "role": element["role"],
          "description": element["description"],
          "applicants": element["applicants"],
        });
      }
      return jobs;
    });
  }
}
