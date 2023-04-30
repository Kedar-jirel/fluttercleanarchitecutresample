import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../core/store/session_manager.dart';
import 'login_controller.dart';

class SignInPage extends View {
  @override
  State<StatefulWidget> createState() => SignInPageState(LoginController());
}

class SignInPageState extends ViewState<SignInPage, LoginController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _obscureText = true;
  bool? isRemembered = false;

  final FocusNode focusMobileNum = new FocusNode();
  final FocusNode focusPass = new FocusNode();
  late LoginController controller;

  void initViewState(LoginController controller) async {
    this.controller = controller;

  }

  SignInPageState(this.controller) : super(controller) {
    initViewState(controller);
  }

  String? validatePassword(String? value) {
    if (value!.trim().isEmpty)
      return "Passord Empty";
    // if (value.trim().length < 6) return kShortPassError;
    return null;
  }

  String? validateMobile(String? value) {
    if (value!.trim().isEmpty)
      return "Mobile Empty";
    if (value.length != 10) return "Invalid number";
    return null;
  }

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      focusMobileNum.unfocus();
      focusPass.unfocus();
      controller.performLogin(isRemembered: isRemembered);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }



  @override
  Widget get view => Scaffold(
    key: globalKey,
    body:  SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Wrap(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            focusNode: focusMobileNum,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              labelText: "Mobile Number",
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            keyboardType: TextInputType.phone,

                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                            validator: validateMobile,
                            controller: controller.mobileNumController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            focusNode: focusPass,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  }),
                              contentPadding: EdgeInsets.all(0.0),
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            keyboardType: TextInputType.text,

                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                            validator: validatePassword,
                            controller: controller.passwordController,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      child: Text("Login"),
                                       onPressed: () {
                                      _validateInputs();
                                    },),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    ),
  );
}
