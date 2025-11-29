import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jwt_auth/constants/api_constants.dart';
import 'package:flutter_jwt_auth/constants/app_strings.dart';
import 'package:flutter_jwt_auth/models/user_model.dart';
import 'package:flutter_jwt_auth/services/manage_secure_storage.dart';

import 'manage_shared_preferences.dart';

class WordPressAuthMethods {
  final Dio _dio = Dio();

  Future<bool> loginToWordPress(
      BuildContext context, String username, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.baseUrl + ApiConstants.wpApiPath + ApiConstants.tokenPath,
        data: {
          ApiConstants.requestKeyUsername: username,
          ApiConstants.requestKeyPassword: password,
        },
      );

      if (response.statusCode == ApiConstants.statusCodeOk) {
        String token = response.data[ApiConstants.responseKeyToken];
        UserModel user = UserModel.fromJson(response.data);

        // Save token to secure storage
        await SecureStorage.saveToken(token);

        // Save user info to shared preferences
        await ManageSharedPreferences.saveUser(user);

        // show success message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.loginSuccessful),
              backgroundColor: Colors.green,
            ),
          );
        }

        // return true
        return true;
      } else {
        // show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.loginFailed),
              backgroundColor: Colors.red,
            ),
          );
        }
        // return false
      }
      return false;
    } catch (error) {
      // show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }

      // return false
      return false;
    }
  }

  Future<bool> registerToWordPress(
      BuildContext context, String username, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.baseUrl +
            ApiConstants.wpApiPath +
            ApiConstants.registerPath,
        data: {
          ApiConstants.requestKeyUsername: username,
          ApiConstants.requestKeyPassword: password,
        },
      );

      String message = response.data[ApiConstants.responseKeyMessage];

      if (response.statusCode == ApiConstants.statusCodeOk &&
          response.data[ApiConstants.responseKeyStatus] ==
              ApiConstants.statusSuccess) {
        // get user id

        // show success message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green,
            ),
          );
        }

        // return true
        return true;
      } else {
        // show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${AppStrings.loginFailed} $message'),
              backgroundColor: Colors.red,
            ),
          );
        }
        // return false
      }
      return false;
    } catch (error) {
      // show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppStrings.internalErrorOccurred} $error'),
            backgroundColor: Colors.red,
          ),
        );
      }

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
      debugPrint(AppStrings.tokenIsNull);
      return false;
    }

    // Set token to dio options
    dio.options.headers[ApiConstants.headerAuthorization] =
        ApiConstants.bearerPrefix + token;

    try {
      Response response = await dio.post(ApiConstants.baseUrl +
          ApiConstants.wpApiPath +
          ApiConstants.tokenValidatePath);

      if (response.data[ApiConstants.responseKeyData]
              [ApiConstants.responseKeyStatus] ==
          ApiConstants.statusCodeOk) {
        // Token is valid
        String code = response.data[ApiConstants.responseKeyCode];
        String userId = response.data[ApiConstants.responseKeyData]
            [ApiConstants.responseKeyUserId];

        if (code == ApiConstants.codeValidToken) {
          debugPrint('${AppStrings.tokenIsValid} $userId');
          return true;
        } else {
          debugPrint(AppStrings.tokenIsInvalid);

          // if token is invalid, clear token and user info
          await clearUser();
          return false;
        }
      } else {
        debugPrint(AppStrings.tokenValidationFailed);
        return false;
      }
    } catch (error) {
      debugPrint('${AppStrings.errorDuringTokenValidation}: $error');
      return false;
    }
  }

  Future<void> clearUser() async {
    await SecureStorage.deleteToken();
    await ManageSharedPreferences.clearUserModel();
  }
}
