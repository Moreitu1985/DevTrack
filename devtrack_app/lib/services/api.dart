import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ Android Emulator URL (important)
  static const String baseUrl = "http://localhost:3000";

  // =========================
  // REGISTER USER
  // =========================
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

  // =========================
  // LOGIN USER
  // =========================
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

  // =========================
  // GET ALL PROJECTS
  // =========================
  static Future getProjects() async {
    final response = await http.get(
      Uri.parse("$baseUrl/projects"),
      headers: {"Content-Type": "application/json"},
    );

    return jsonDecode(response.body);
  }

  // =========================
  // CREATE PROJECT
  // =========================
  static Future createProject(
    int userId,
    String title,
    String description,
    String stage,
    String support,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/projects"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "title": title,
        "description": description,
        "stage": stage,
        "support_needed": support,
      }),
    );

    return jsonDecode(response.body);
  }
}