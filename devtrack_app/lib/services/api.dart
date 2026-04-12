import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:3000";

  static Future register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future getProjects() async {
    final response = await http.get(
      Uri.parse("$baseUrl/projects"),
      headers: {"Content-Type": "application/json"},
    );

    return jsonDecode(response.body);
  }

  static Future createProject(
    int userId,
    String title,
    String description,
    String stage,
    String support,
    String visibility,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/projects/create"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "title": title,
        "description": description,
        "stage": stage,
        "support_needed": support,
        "visibility": visibility,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future updateProjectStage(int projectId, String stage) async {
    final response = await http.put(
      Uri.parse("$baseUrl/projects/update-stage/$projectId"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "stage": stage,
      }),
    );

    return jsonDecode(response.body);
  }
}