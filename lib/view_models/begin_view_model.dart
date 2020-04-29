import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BeginViewModel extends Model {
  BeginViewModel() {
    currentPage = 0;
    mainPageController = PageController();
    firstNameTextController = TextEditingController();
    lastNameTextController = TextEditingController();
    locationTextController = TextEditingController();
    emailTextController = TextEditingController();
    bioTextController = TextEditingController();
    usernameTextController = TextEditingController();
    passwordTextController = TextEditingController();
    firstName = "";
    lastName = "";
    location = "";
    email = "";
    bio = "";
    username = "";
    password = "";
  }

  PageController _mainPageController;

  PageController get mainPageController => _mainPageController;

  set mainPageController(PageController value) {
    _mainPageController = value;
    notifyListeners();
  }

  int _currentPage;

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  /// First name
  TextEditingController _firstNameTextController;

  TextEditingController get firstNameTextController => _firstNameTextController;

  set firstNameTextController(TextEditingController value) {
    _firstNameTextController = value;
    notifyListeners();
  }

  String _firstName;

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  /// Last name
  TextEditingController _lastNameTextController;

  TextEditingController get lastNameTextController => _lastNameTextController;

  set lastNameTextController(TextEditingController value) {
    _lastNameTextController = value;
    notifyListeners();
  }

  String _lastName;

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  /// Location
  TextEditingController _locationTextController;

  TextEditingController get locationTextController => _locationTextController;

  set locationTextController(TextEditingController value) {
    _locationTextController = value;
    notifyListeners();
  }

  String _location;

  String get location => _location;

  set location(String value) {
    _location = value;
    notifyListeners();
  }

  /// Email
  TextEditingController _emailTextController;

  TextEditingController get emailTextController => _emailTextController;

  set emailTextController(TextEditingController value) {
    _emailTextController = value;
    notifyListeners();
  }

  String _email;

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  /// Short bio
  TextEditingController _bioTextController;

  TextEditingController get bioTextController => _bioTextController;

  set bioTextController(TextEditingController value) {
    _bioTextController = value;
    notifyListeners();
  }

  String _bio;

  String get bio => _bio;

  set bio(String value) {
    _bio = value;
    notifyListeners();
  }

  /// Username
  TextEditingController _usernameTextController;

  TextEditingController get usernameTextController => _usernameTextController;

  set usernameTextController(TextEditingController value) {
    _usernameTextController = value;
    notifyListeners();
  }

  String _username;

  String get username => _username;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  /// Password
  TextEditingController _passwordTextController;

  TextEditingController get passwordTextController => _passwordTextController;

  set passwordTextController(TextEditingController value) {
    _passwordTextController = value;
    notifyListeners();
  }

  String _password;

  String get password => _password;

  set password(String value) {
    _password = value;
    notifyListeners();
  }
}
