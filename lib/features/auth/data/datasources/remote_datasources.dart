import 'dart:convert';
import 'package:amar_taka/features/auth/data/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:amar_taka/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSources{
  Future<String> login(String userName, String password);
  Future<void> signup(String userName, String email, String password);
  Future<void> logout();
  Future<void> storeToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSources{
  final http.Client client;
  final SharedPreferences sharedPreferences;

  AuthRemoteDataSourceImpl({required this.client, required this.sharedPreferences});

  @override
  Future<String> login(String userName, String password) async{
  final url = Uri.parse("${AppConstants.apiBaseUrl!}/public/sign-in");

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userName": userName,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final token = response.body; // It’ll be like: Bearer Token : <JWT>
      await storeToken(token);
      print('Logged in successfully. Token: $token');
      return token; // Return the token directly
    } else {
      print('Failed to login: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception(response.body);
    }
  } catch (e) {
    print('Error occurred: $e');
    throw Exception(e);
  }
  }
  

  @override
  Future<void> logout() async {
    try {
      final token = await getToken();
      final response = await client.post(
        Uri.parse("${AppConstants.apiBaseUrl!}/public/logout"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        await clearToken();
        print('Logged out successfully');
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  @override
  Future<void> signup(String userName, String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse("${AppConstants.apiBaseUrl!}/public/sign-up"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(UserModel(
          userName: userName,
          email: email,
          password: password,
        ).toJson()),
      );
      if (response.statusCode == 200) {
        return;
      } else {
        print(response.body);
        throw Exception(response.body);
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Signup failed: $e");
    }
  }

  @override
  Future<void> storeToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString('token');
  }

  @override
  Future<void> clearToken() async {
    await sharedPreferences.remove('token');
  }
}