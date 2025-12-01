import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "https://blackdiamondcar.com/api";

  // ---------------- GET TOKEN ----------------
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('api_token');
  }

  // ---------------- HEADERS ----------------
  Future<Map<String, String>> _headers({bool auth = false}) async {
    final token = await _getToken();

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (auth && token != null) 'Authorization': 'Bearer $token',
    };
  }

  // ---------------- LOGIN ----------------
  Future<Map<String, dynamic>> login(String phone, String password) async {
    final response = await _post(
      '/store-login',
      {'phone': phone, 'password': password},
      auth: false,
    );

    if (response["access_token"] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('api_token', response["access_token"]);
    }

    return response;
  }

  // ---------------- REGISTER ----------------
  Future<Map<String, dynamic>> register(
      String name, String phone, String password) async {
    return _post('/store-register',
        {'name': name, 'phone': phone, 'password': password});
  }

  // ---------------- GENERIC GET ----------------
  Future<Map<String, dynamic>> _get(String endpoint,
      {bool auth = false}) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _headers(auth: auth),
    );

    return _process(response);
  }

  // ---------------- GENERIC POST ----------------
  Future<Map<String, dynamic>> _post(String endpoint, Map<String, dynamic> data,
      {bool auth = false}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _headers(auth: auth),
      body: jsonEncode(data),
    );

    return _process(response);
  }

  // ---------------- PROCESS RESPONSE ----------------
  Map<String, dynamic> _process(http.Response response) {
    final decoded = jsonDecode(response.body);

    if (response.statusCode == 401) {
      return {
        'success': false,
        'status': 401,
        'message': "Unauthenticated",
      };
    }

    return decoded;
  }

  // ---------------- CARS ----------------
  Future<List<dynamic>> getCars({int page = 1}) async {
    final data = await _get('/listings?page=$page');
    return data['cars']?['data'] ?? [];
  }

  Future<Map<String, dynamic>> getCarDetails(String id) async {
    return _get('/listing/$id');
  }

  // ---------------- USER REQUIRED AUTH ----------------
  Future<Map<String, dynamic>> getUserDashboard() async {
    return _get('/user/dashboard', auth: true);
  }

  Future<Map<String, dynamic>> getWishlists() async {
    return _get('/user/wishlists', auth: true);
  }

  Future<Map<String, dynamic>> getProfile() async {
    return _get('/user/edit-profile', auth: true);
  }

  // Add all other user endpoints here...

  // ---------------- LOGOUT ----------------
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('api_token');
  }
}
