import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_jwt_auth/models/user_model.dart';
import 'package:flutter_jwt_auth/services/secure_storage.dart';

import 'manage_shared_preferences.dart';

class WordPressAuthMethods {
  final String _baseUrl = 'https://scriptyuvasi.com/';
  final String _wpApiPath = 'wp-json/jwt-auth/v1/';
  final String _wpTokenPath = 'token';
  final String _wpTokenValidatePath = 'token/validate';
  final String _wpRegisterPath = 'register';
  final Dio _dio = Dio();

  Future<UserModel> loginToWordPress(String email, String password) async {
    try {
      final response = await _dio.post(
        _baseUrl + _wpApiPath + _wpTokenPath,
        data: {
          'username': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final wordpressLoginModel = UserModel.fromJson(data);
        return wordpressLoginModel;
      } else {
        throw Exception('Login failed');
      }
    } catch (error) {
      throw Exception('Login error: $error');
    }
  }

  Future<bool> registerToWordPress(String email, String password) async {
    try {
      final response = await _dio.post(
        _baseUrl + _wpApiPath + _wpRegisterPath,
        data: {
          'username': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Registration failed');
      }
    } catch (error) {
      throw Exception('Registiration error: $error');
    }
  }

  Future<bool> validateUserToken() async {
    Dio dio = Dio();

    // Get token from secure storage
    String? token = await SecureStorage.getToken();
    if (token == null) {
      debugPrint('Token is null');
      return false;
    }

    // Set token to dio options
    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response =
          await dio.post(_baseUrl + _wpApiPath + _wpTokenValidatePath);

      if (response.statusCode == 200) {
        // Token is valid
        String code = response.data['code'];
        String userId = response.data['data']['user_id'];

        if (code == 'jwt_auth_valid_token') {
          debugPrint('Token is valid for user $userId');
          return true;
        } else {
          debugPrint('Token is invalid');

          // if token is invalid, clear token and user info
          await clearUserToken();
          return false;
        }
      } else {
        debugPrint('Token validation request failed');
        return false;
      }
    } catch (error) {
      debugPrint('An error occurred during token validation: $error');
      return false;
    }
  }

  clearUserToken() async {
    await SecureStorage.deleteToken();
    await ManageSharedPreferences.clearUser();
  }
}
