import 'package:flutter/material.dart';
import 'package:easy_cv/constants/strings.dart';

import 'package:easy_cv/utils/extensions.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController usernameController;

  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode nameFocusNode;
  final FocusNode usernameFocusNode;

  final PageController pageController;

  final Function goToSecondPage;

  const SignUpForm({
    Key key,
    this.emailController,
    this.passwordController,
    this.nameController,
    this.usernameController,
    this.emailFocusNode,
    this.passwordFocusNode,
    this.nameFocusNode,
    this.usernameFocusNode,
    this.pageController,
    this.goToSecondPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: _buildMobileUi(context),
    );
  }

  Widget _buildMobileUi(BuildContext context) {
    const pageHeight = 128.0;
    return Container(
      height: pageHeight,
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildEmailField(context).addMarginTop(),
              _buildPasswordField(context).addMarginTop(),
            ],
          ).addPaddingHorizontal(),
          Column(
            children: <Widget>[
              _buildNameField(context).addMarginTop(),
              _buildUsernameField(context).addMarginTop(),
            ],
          ).addPaddingHorizontal(),
        ],
      ),
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

  Widget _buildNameField(BuildContext context) {
    return TextFormField(
      controller: nameController,
      focusNode: nameFocusNode,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: fullNameTitle,
        hintText: fullNameTitle,
      ),
      onEditingComplete: () {
        usernameFocusNode.requestFocus();
      },
    );
  }

  Widget _buildUsernameField(BuildContext context) {
    return TextFormField(
      controller: usernameController,
      focusNode: usernameFocusNode,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: usernameTitle,
        hintText: usernameTitle,
      ),
      onEditingComplete: () {
        context.hideKeyboard();
      },
    );
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
        await goToSecondPage();
        nameFocusNode.requestFocus();
      },
    ).wrapHero("password_field");
  }
}
