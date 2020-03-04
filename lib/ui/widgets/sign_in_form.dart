import 'package:flutter/material.dart';
import 'package:easy_cv/constants/strings.dart';

import 'package:easy_cv/utils/extensions.dart';

class SignInForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  const SignInForm({
    Key key,
    this.emailController,
    this.passwordController,
    this.emailFocusNode,
    this.passwordFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          _buildEmailField(context),
          _buildPasswordField(context).addMarginTop(),
        ],
      ).addPaddingHorizontal(),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return TextFormField(
      controller: emailController,
      focusNode: emailFocusNode,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: emailTitle,
        hintText: emailTitle,
      ),
      onEditingComplete: () {
        passwordFocusNode.requestFocus();
      },
    ).wrapHero("email_field");
  }

  Widget _buildPasswordField(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      focusNode: passwordFocusNode,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: passwordTitle,
        hintText: passwordTitle,
      ),
      onEditingComplete: () async {
        context.hideKeyboard();
      },
    ).wrapHero("password_field");
  }
}
