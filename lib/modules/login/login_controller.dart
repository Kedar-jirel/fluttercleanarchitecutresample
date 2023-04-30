
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import '../../core/app/app_config.dart';
import '../../core/store/session_manager.dart';
import '../../domain/entities/auth/model/user.dart';
import '../../domain/entities/auth/param/loginparam.dart';
import '../../network/network_exceptions.dart';
import 'login_presenter.dart';

class LoginController extends Controller {
  TextEditingController? mobileNumController;
  TextEditingController? passwordController;
  final LoginPresenter _loginPresenter;
  late SessionManager sessionManager;
  bool? isRememberedd;

  LoginController() : _loginPresenter = LoginPresenter() {
    mobileNumController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void initListeners() {
    _loginPresenter.onError = _onError;
    _loginPresenter.onComplete = _onComplete;
    _loginPresenter.onNext = _onNext;
    sessionManager = SessionManager();
  }

  void performLogin(
      {bool? isRemembered = false, bool fingerPrintLogin = false}) {
       // showProgress();
    isRememberedd = isRemembered;
    _loginPresenter.performLogin( LoginUsecaseParam());
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onError(AppException error) {
    EasyLoading.showError(error.message);
  }

  _onComplete() {
    GetIt.I<AppConfig>()..getappConfigMap();
  }

  _onNext(User user) {
    // dismiss();
    // SessionManager()
    //     .saveCredentials(token: user.token!, user: user)
    //     .then((value) {
    //   storeRememberedData(isRememberedd!);
    //   SessionManager().setIsGuestSession(false);
    //   // if (user.enforcePasswordChange!) {
    //   //   getContext().router.push(ChangePasswordRoute());
    //   // } else {
    //   //   getContext().read<IndexProviderController>().navigateByIndex(1);
    //   //   getContext().router.pushAndPopUntil(MainPageViewerRoute(index: 1),
    //   //       predicate: (route) => false);
    //   // }
    // });
  }



  void bioMetricLogin(bool? isRemembered) {
    performLogin(fingerPrintLogin: true, isRemembered: isRemembered);
  }

  void setRememberedData() async {
    String? password = await sessionManager.getRememberedPassword();
    String? username = await sessionManager.getRememberedUserName();
    if (password != null && username != null) {
      passwordController!.value = TextEditingValue(text: password);
      mobileNumController!.value = TextEditingValue(text: username);
    }
  }

  void storeRememberedData(bool isRemembered) async {
    if (isRemembered) {
      sessionManager.setRememberedPassword(passwordController!.text);
      sessionManager.setRememberedUserName(mobileNumController!.text);
    }
    sessionManager.setRemembered(isRemembered);
  }

}
