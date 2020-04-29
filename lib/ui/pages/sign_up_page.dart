import 'package:easy_cv/constants/strings.dart';
import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/ui/pages/sign_in_page.dart';
import 'package:easy_cv/ui/widgets/auth_hint.dart';
import 'package:easy_cv/ui/widgets/logo.dart';
import 'package:easy_cv/ui/widgets/sign_up_form.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "/sign_up";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();

  final _signUpPageController = PageController();

  AnimationController _animationController;
  final Tween<double> _backButtonScaleTween = Tween(begin: 0.0, end: 1.0);

  bool _buttonEnabled = true;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      top: false,
      child: Center(
        child: Column(
          children: <Widget>[
            Logo(),
            _buildSignUp(context),
            Expanded(child: Container(color: Colors.white)),
            Container(color: Colors.grey[300], height: 1.0),
            AuthHint(
              route: SignInPage().route(context),
              preLabel: signInHint,
              label: signInTitle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSignUpForm().addMarginTop(3),
          _buildButtons(context).addMarginTop(3),
        ],
      ),
    );
  }

  Widget _buildSignUpForm() {
    return SignUpForm(
      pageController: _signUpPageController,
      emailController: _emailController,
      passwordController: _passwordController,
      nameController: _nameController,
      usernameController: _usernameController,
      emailFocusNode: _emailFocusNode,
      nameFocusNode: _nameFocusNode,
      usernameFocusNode: _usernameFocusNode,
      passwordFocusNode: _passwordFocusNode,
      goToSecondPage: _goToSecondSignUpPage,
    );
  }

  bool get isOnSecondPage =>
      _signUpPageController.hasClients &&
      (_signUpPageController?.page ?? 0.0).round() >= 1;

  Widget _buildButtons(BuildContext context) {
    return AnimatedBuilder(
      animation: _backButtonScaleTween.animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        ),
      ),
      builder: (BuildContext context, _) {
        return Row(
          children: <Widget>[
            _buildBackButton(),
            _getMainButton(),
          ],
        );
      },
    ).addPaddingHorizontal().wrapHero("auth_button");
  }

  Widget _buildBackButton() {
    const backButtonSize = 48.0;
    return Container(
      width: backButtonSize * _animationController.value,
      child: IconButton(
        onPressed: () async {
          await _goToFirstSignUpPage();
          _passwordFocusNode.requestFocus();
        },
        icon: Icon(
          Icons.arrow_back,
          color: context.theme.primaryColor,
        ),
      ),
    );
  }

  Widget _getMainButton() {
    final title = _getMainButtonTitle() + signUpTitle;
    return Expanded(
      child: RaisedButton(
        onPressed: () => _handleMainButtonPressed(),
        child: _buttonEnabled.ifTrue(
          Text(
            title.toUpperCase(),
          ),
        ),
      ),
    );
  }

  _handleMainButtonPressed() async {
    if (isOnSecondPage) {
      if (_buttonEnabled) {
        _handleSignUpPressed();
      }
    } else {
      await _goToSecondSignUpPage();
      _nameFocusNode.requestFocus();
    }
  }

  Future _goToFirstSignUpPage() async {
    if (_signUpPageController.hasClients) {
      _animationController.reverse();
      await _signUpPageController.goTo(0);
      setState(() {});
    }
  }

  Future _goToSecondSignUpPage() async {
    if (_signUpPageController.hasClients) {
      _animationController.forward();
      await _signUpPageController.goTo(1);
      setState(() {});
    }
  }

  Future<void> _handleSignUpPressed() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text.trim();
    final username = _usernameController.text.trim();

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

    /// Validate name
    if (!await validateInput(
      name,
      RegexUtils.name,
      false,
      _nameFocusNode,
      _nameController,
      invalidNameMessage,
    )) {
      return;
    }

    /// Validate username
    if (!await validateInput(
      username,
      RegexUtils.username,
      false,
      _usernameFocusNode,
      _usernameController,
      invalidUsernameMessage,
    )) {
      return;
    }

    appViewModel.signUp(email, password, name, username, onError: (
      error,
    ) {
      context.showAlertDialog(
        title: signUpFail,
        message: error.message,
      );
      resetButtonState();
    });
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

      if (isOnFirstPage) {
        await _goToFirstSignUpPage();
      } else {
        await _goToSecondSignUpPage();
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

  String _getMainButtonTitle() {
    return isOnSecondPage.ifTrue(
      "(2/2) ",
      "(1/2) ",
    );
  }
}
