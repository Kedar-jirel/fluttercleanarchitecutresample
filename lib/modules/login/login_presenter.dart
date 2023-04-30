import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../domain/entities/auth/model/user.dart';
import '../../domain/entities/auth/param/loginparam.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_mixin.dart';

class LoginPresenter extends Presenter with LoginMixin {
  late LoginUseCase _loginUseCase;

  LoginPresenter() {
    _loginUseCase = LoginUseCase();
  }

  void performLogin(LoginUsecaseParam params) {
    _loginUseCase.execute(_loginUsecaseObserver(this), params);
  }

  @override
  void dispose() {
    _loginUseCase.dispose();
  }
}

class _loginUsecaseObserver implements Observer<User> {
  final LoginPresenter _presenter;

  _loginUsecaseObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.onComplete();
  }

  @override
  void onError(e) {
    _presenter.onError(e);
  }

  @override
  void onNext(User? response) {
    _presenter.onNext(response);
  }
}
