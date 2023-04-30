import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:get_it/get_it.dart';

import '../../network/network_exceptions.dart';
import '../entities/auth/model/user.dart';
import '../entities/auth/param/loginparam.dart';
import '../repository/auth/auth_repo.dart';
import '../repository/auth/i_auth_repo.dart';

class LoginUseCase extends CompletableUseCase<LoginUsecaseParam> {
  AuthRepo _authRepo = GetIt.I<IAuthRepo>() as AuthRepo;

  @override
  Future<Stream<void>> buildUseCaseStream(LoginUsecaseParam? params) async {
    final StreamController<void> controller = StreamController();
    try {
      User user = await _authRepo.login(params: params);
      logger.finest('Login request successful');
      controller.add(user);
      controller.close();
    } on Exception catch (e, stacktrace) {
      print(stacktrace);
      logger.severe("exeption on Login Request");
      controller.addError(e is AppException ? e : AppException(message: ""));
    }
    return controller.stream;
  }
}

