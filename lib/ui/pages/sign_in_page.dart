import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_cv/constants/strings.dart';
import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/ui/pages/home_page.dart';
import 'package:easy_cv/ui/widgets/logo.dart';

import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/utils/string_utils.dart';
import 'package:easy_cv/ui/widgets/auth_hint.dart';
import 'package:easy_cv/ui/widgets/loading_indicator.dart';
import 'package:easy_cv/ui/widgets/sign_in_form.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = "/sign_in";

  @override
  _SignInPageState createState() => _SignInPageState();
}

final _emailController = TextEditingController(text: "simon@petpaw.app");
final _passwordController = TextEditingController(text: "1234567");

class _SignInPageState extends State<SignInPage> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _signInPagePageController = PageController();

  bool _buttonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: _buildMainUi(context),
      ),
    );
  }

  Widget _buildMainUi(BuildContext context) {
    return Column(
      children: <Widget>[
        Logo().addMarginTop(),
        _buildSignInPage(context).addMarginTop(),
        Expanded(child: Container(color: Colors.transparent)),
        Container(color: Colors.grey[300], height: 1.0),
        AuthHint(
          onTap: () => context.navigator.pop(),
          preLabel: signUpHint,
          label: signUpTitle,
        ),
      ],
    );
  }

  Widget _buildSignInPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSignInPageForm().addMarginTop(3),
          _buildLoginButton(context).addMarginTop(3),
        ],
      ),
    );
  }

  Widget _buildSignInPageForm() {
    return SignInForm(
      emailController: _emailController,
      passwordController: _passwordController,
      emailFocusNode: _emailFocusNode,
      passwordFocusNode: _passwordFocusNode,
    );
  }

  bool get isOnSecondPage =>
      _signInPagePageController.hasClients &&
      (_signInPagePageController?.page ?? 0.0).round() >= 1;

  Widget _buildLoginButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            onPressed: () => _handleMainButtonPressed(),
            child: _buttonEnabled.ifTrue(
              Text(signInTitle.toUpperCase()),
              LoadingIndicator(
                color: context.theme.primaryColor,
              ),
            ),
          ),
        ),
      ],
    ).addPaddingHorizontal().wrapHero("auth_button");
  }

  _handleMainButtonPressed() async {
    if (_buttonEnabled) {
      _handleSignInPagePressed();
    }
  }

  Future<void> _handleSignInPagePressed() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _buttonEnabled = false;
    });

    /// Validate email
    if (!await validateInput(
      email,
      RegexUtils.email,
      true,
      _emailFocusNode,
      _emailController,
      invalidEmailMessage,
    )) {
      return;
    }

    /// Validate password
    if (!await validateInput(
      password,
      RegexUtils.password,
      true,
      _passwordFocusNode,
      _passwordController,
      invalidPasswordMessage,
    )) {
      return;
    }

    final bool result =
        await appViewModel.signInWithEmailPassword(email, password, onError: (
      error,
    ) {
      context.showAlertDialog(
        title: signUpFail,
        message: error.message,
      );
      resetButtonState();
    });
    if (result) {
      context.navigator.pushReplacementNamed(HomePage.routeName);
    }
  }

  Future<bool> validateInput(
    String text,
    Pattern pattern,
    bool isOnFirstPage,
    FocusNode focusNode,
    TextEditingController textController, [
    String errorMessage = "",
  ]) async {
    if (text.isEmpty || !text.validate(pattern)) {
      if (errorMessage.isNotEmpty) {
        await context.showAlertDialog(
          title: invalidInputTitle,
          message: errorMessage,
        );
      }

      focusNode.requestFocus();
      textController.selectAll();
      resetButtonState();

      return false;
    }
    return true;
  }

  void resetButtonState() {
    setState(() {
      _buttonEnabled = true;
    });
  }
}
