import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jwt_auth/models/user_model.dart';
import 'package:flutter_jwt_auth/services/manage_secure_storage.dart';

import 'manage_shared_preferences.dart';

class WordPressAuthMethods {
  final String _baseUrl = 'https://scriptyuvasi.com/';
  final String _wpApiPath = 'wp-json/jwt-auth/v1/';
  final String _wpTokenPath = 'token';
  final String _wpTokenValidatePath = 'token/validate';
  final String _wpRegisterPath = 'register';
  final Dio _dio = Dio();

  Future<bool> loginToWordPress(
      context, String username, String password) async {
    try {
      final response = await _dio.post(
        _baseUrl + _wpApiPath + _wpTokenPath,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        String token = response.data['token'];
        UserModel user = UserModel(
          token: token,
          userId: response.data['user_id'],
          userEmail: response.data['user_email'],
          userNicename: response.data['user_nicename'],
          userDisplayName: response.data['user_display_name'],
          userRole: response.data['user_role'],
        );

        // Save token to secure storage
        await SecureStorage.saveToken(token);

        // Save user info to shared preferences
        await ManageSharedPreferences.saveUser(user);

        // show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful'),
            backgroundColor: Colors.green,
          ),
        );

        // return true
        return true;
      } else {
        // show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed'),
            backgroundColor: Colors.red,
          ),
        );
        // return false
      }
      return false;
    } catch (error) {
      // show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username or password is incorrect'),
          backgroundColor: Colors.red,
        ),
      );

      // return false
      return false;
    }
  }

  Future<bool> registerToWordPress(
      context, String username, String password) async {
    try {
      final response = await _dio.post(
        _baseUrl + _wpApiPath + _wpRegisterPath,
        data: {
          'username': username,
          'password': password,
        },
      );

      String message = response.data['message'];

      if (response.statusCode == 200 && response.data['status'] == "success") {
        // get user id
        String userId = response.data['user_id'];

        // show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$message $userId'),
            backgroundColor: Colors.green,
          ),
        );

        // return true
        return true;
      } else {
        // show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed $message'),
            backgroundColor: Colors.red,
          ),
        );
        // return false
      }
      return false;
    } catch (error) {
      // show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Internal Error Occurred $error'),
          backgroundColor: Colors.red,
        ),
      );

      // return false
      return false;
    }
  }

  Future<bool> validateUserToken() async {
    // Valid Token Response
    // {
    //   "code": "jwt_auth_valid_token",
    //   "data": {
    //       "status": 200,
    //       "user_id": "9"
    //   }
    // }

    // Invalid Token Response
    // {
    //   "code": "jwt_auth_invalid_token",
    //   "message": "Unexpected control character found",
    //   "data": {
    //       "status": 403
    //   }
    // }

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

      if (response.data['data']['status'] == 200) {
        // Token is valid
        String code = response.data['code'];
        String userId = response.data['data']['user_id'];

        if (code == 'jwt_auth_valid_token') {
          debugPrint('Token is valid for user $userId');
          return true;
        } else {
          debugPrint('Token is invalid');

          // if token is invalid, clear token and user info
          await clearUser();
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

  clearUser() async {
    await SecureStorage.deleteToken();
    await ManageSharedPreferences.clearUserModel();
  }
}
