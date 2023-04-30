import 'package:flutter/foundation.dart';

import '../../entities/auth/model/user.dart';
import '../../entities/auth/param/loginparam.dart';

abstract class IAuthRepo {
  // Future<void> requestOtp({required OtpUseCaseParam params});
  //
  // Future<void> validateOtp({required OtpUseCaseParam params});
  //
  // Future<void> signup({required SignupUseCaseParam params});
  //
  // Future<void> forgetPassword({required ForgetPasswordUseCaseParam params});
  //
  // Future<void> resetPassword({required ResetPasswordUseCaseParam params});
  //
  // Future<void> changePassword({required ResetPasswordUseCaseParam params});

  Future<User> login({LoginUsecaseParam? params});

  Future<void> logout();

  // Future<void> getPasswordPolicy();
  //
  // Future<String?> updateDeviceToken();
}
