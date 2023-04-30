
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../../../network/api_base_helper.dart';
import '../../entities/auth/model/user.dart';
import '../../entities/auth/param/loginparam.dart';
import 'i_auth_repo.dart';


class AuthRepo implements IAuthRepo {
  Future<dynamic> fetchServerConfig() async {
    try {
      final response = await ApiBaseHelper().get("");
      return response;
    } on Exception {
      rethrow;
    }
  }

  // @override
  // Future<void> validateOtp({required OtpUseCaseParam params}) async {
  //   try {
  //     final response = await ApiBaseHelper().post(validateOtpUrl,
  //         body: {'otp': params.otp, 'receiver': params.reciever});
  //   } on Exception {
  //     rethrow;
  //   }
  // }
  //
  // @override
  // Future<void> requestOtp({required OtpUseCaseParam params}) async {
  //   try {
  //     final response = await ApiBaseHelper()
  //         .post(requestOtpUrl, body: {'receiver': params.reciever});
  //   } on Exception {
  //     rethrow;
  //   }
  // }
  //
  // Future<void> resendOtp({required OtpResendUseCaseParam params}) async {
  //   try {
  //     final response = await GetIt.I<ApiBaseHelper>()
  //         .post(resendOtpUrl, body: {'receiver': params.reciever});
  //   } on Exception {
  //     rethrow;
  //   }
  // }
  //
  // @override
  // Future<void> signup({required SignupUseCaseParam params}) async {
  //   try {
  //     final response = await ApiBaseHelper().post(signupUrl, body: {
  //       'mobileNumber': params.mobileNumber,
  //       'firstName': params.firstName,
  //       'middleName': params.middleName,
  //       'lastName': params.lastName,
  //       'password': params.password
  //     });
  //   } on Exception {
  //     rethrow;
  //   }
  // }
  //
  // @override
  // Future<String?> updateDeviceToken() async {
  //   try {
  //     final response =
  //         await ApiBaseHelper().put(updateDeviceTokenUrl, body: {});
  //     UpdateDeviceTokenResponse value =
  //         await compute(responseToUpdateDeviceToken, response['data']);
  //     return value.token;
  //   } on Exception {
  //     rethrow;
  //   }
  // }
  //
  // @override
  // Future<void> forgetPassword(
  //     {required ForgetPasswordUseCaseParam params}) async {
  //   try {
  //     final response = await ApiBaseHelper()
  //         .put(forgetPasswordUrl, body: {'username': params.mobileNumber});
  //   } on Exception {
  //     rethrow;
  //   }
  // }
  //
  // // "oldPassword":"Test@122",
  // // "newPassword" :"Test@123",
  // // "confirmNewPassword" :"Test@123"
  // //
  // @override
  // Future<void> changePassword(
  //     {required ResetPasswordUseCaseParam params}) async {
  //   try {
  //     final response = await ApiBaseHelper().put(changePasswordUrl, body: {
  //       'confirmNewPassword': params.password,
  //       'oldPassword': params.oldPassword,
  //       'newPassword': params.password
  //     });
  //   } on Exception {
  //     rethrow;
  //   }
  // }
  //
  // @override
  // Future<void> resetPassword(
  //     {required ResetPasswordUseCaseParam params}) async {
  //   try {
  //     final response = await ApiBaseHelper().put(resetPasswordUrl, body: {
  //       'username': params.mobileNumber,
  //       'otp': params.otp,
  //       'newPassword': params.password
  //     });
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  @override
  Future<User> login({LoginUsecaseParam? params}) async {
    try {
      // var loginBody = params.isFingerPrintLogin
      //     ? {
      //         'deviceId': await getDeviceId(),
      //         'token': await SessionManager().getDeviceToken(),
      //       }
      //     : {'username': params.username, "password": params.password};
      // var url = params.isFingerPrintLogin ? fingerPrintLoginUrl : loginUrl;
      // final response = await GetIt.I<ApiBaseHelper>().post(url, body: loginBody);
      // return compute(responseToUser, response['data']);
      return User();
    } on Exception {
      rethrow;
    }
  }



  @override
  Future<void> logout() async {
    try {
      final response = await ApiBaseHelper().put("logoutUrl", body: {});
    } on Exception {
      rethrow;
    }
  }

  // @override
  // Future<PasswordPolicy> getPasswordPolicy() async {
  //   try {
  //     final response = await GetIt.I<ApiBaseHelper>().get(passwordPolicyUrl);
  //     return PasswordPolicy.fromJson(response['data']["passwordPolicyInfo"]);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
