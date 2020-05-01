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
    introTextController = TextEditingController();
    usernameTextController = TextEditingController();
    passwordTextController = TextEditingController();
    schoolTextController = TextEditingController();
    majorTextController = TextEditingController();
    companyTextController = TextEditingController();
    positionTextController = TextEditingController();
    companyLocationTextController = TextEditingController();
    firstNameFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
    locationFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    bioFocusNode = FocusNode();
    introFocusNode = FocusNode();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    schoolFocusNode = FocusNode();
    majorFocusNode = FocusNode();
    companyFocusNode = FocusNode();
    positionFocusNode = FocusNode();
    companyLocationFocusNode = FocusNode();
    firstName = "";
    lastName = "";
    location = "";
    email = "";
    bio = "";
    intro = "";
    username = "";
    password = "";
    school = "";
    major = "";
    company = "";
    position = "";
    companyLocation = "";
    isWaiting = false;
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

  FocusNode _firstNameFocusNode;

  FocusNode get firstNameFocusNode => _firstNameFocusNode;

  set firstNameFocusNode(FocusNode value) {
    _firstNameFocusNode = value;
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

  FocusNode _lastNameFocusNode;

  FocusNode get lastNameFocusNode => _lastNameFocusNode;

  set lastNameFocusNode(FocusNode value) {
    _lastNameFocusNode = value;
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

  FocusNode _locationFocusNode;

  FocusNode get locationFocusNode => _locationFocusNode;

  set locationFocusNode(FocusNode value) {
    _locationFocusNode = value;
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

  FocusNode _emailFocusNode;

  FocusNode get emailFocusNode => _emailFocusNode;

  set emailFocusNode(FocusNode value) {
    _emailFocusNode = value;
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

  FocusNode _bioFocusNode;

  FocusNode get bioFocusNode => _bioFocusNode;

  set bioFocusNode(FocusNode value) {
    _bioFocusNode = value;
    notifyListeners();
  }

  String _bio;

  String get bio => _bio;

  set bio(String value) {
    _bio = value;
    notifyListeners();
  }

  /// Intro
  TextEditingController _introTextController;

  TextEditingController get introTextController => _introTextController;

  set introTextController(TextEditingController value) {
    _introTextController = value;
    notifyListeners();
  }

  FocusNode _introFocusNode;

  FocusNode get introFocusNode => _introFocusNode;

  set introFocusNode(FocusNode value) {
    _introFocusNode = value;
    notifyListeners();
  }

  String _intro;

  String get intro => _intro;

  set intro(String value) {
    _intro = value;
    notifyListeners();
  }

  /// Username
  TextEditingController _usernameTextController;

  TextEditingController get usernameTextController => _usernameTextController;

  set usernameTextController(TextEditingController value) {
    _usernameTextController = value;
    notifyListeners();
  }

  FocusNode _usernameFocusNode;

  FocusNode get usernameFocusNode => _usernameFocusNode;

  set usernameFocusNode(FocusNode value) {
    _usernameFocusNode = value;
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

  FocusNode _passwordFocusNode;

  FocusNode get passwordFocusNode => _passwordFocusNode;

  set passwordFocusNode(FocusNode value) {
    _passwordFocusNode = value;
    notifyListeners();
  }

  String _password;

  String get password => _password;

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  /// School
  TextEditingController _schoolTextController;

  TextEditingController get schoolTextController => _schoolTextController;

  set schoolTextController(TextEditingController value) {
    _schoolTextController = value;
    notifyListeners();
  }

  FocusNode _schoolFocusNode;

  FocusNode get schoolFocusNode => _schoolFocusNode;

  set schoolFocusNode(FocusNode value) {
    _schoolFocusNode = value;
    notifyListeners();
  }

  String _school;

  String get school => _school;

  set school(String value) {
    _school = value;
    notifyListeners();
  }

  /// Major
  TextEditingController _majorTextController;

  TextEditingController get majorTextController => _majorTextController;

  set majorTextController(TextEditingController value) {
    _majorTextController = value;
    notifyListeners();
  }

  FocusNode _majorFocusNode;

  FocusNode get majorFocusNode => _majorFocusNode;

  set majorFocusNode(FocusNode value) {
    _majorFocusNode = value;
    notifyListeners();
  }

  String _major;

  String get major => _major;

  set major(String value) {
    _major = value;
    notifyListeners();
  }

  /// Company
  TextEditingController _companyTextController;

  TextEditingController get companyTextController => _companyTextController;

  set companyTextController(TextEditingController value) {
    _companyTextController = value;
    notifyListeners();
  }

  FocusNode _companyFocusNode;

  FocusNode get companyFocusNode => _companyFocusNode;

  set companyFocusNode(FocusNode value) {
    _companyFocusNode = value;
    notifyListeners();
  }

  String _company;

  String get company => _company;

  set company(String value) {
    _company = value;
    notifyListeners();
  }

  /// Position
  TextEditingController _positionTextController;

  TextEditingController get positionTextController => _positionTextController;

  set positionTextController(TextEditingController value) {
    _positionTextController = value;
    notifyListeners();
  }

  FocusNode _positionFocusNode;

  FocusNode get positionFocusNode => _positionFocusNode;

  set positionFocusNode(FocusNode value) {
    _positionFocusNode = value;
    notifyListeners();
  }

  String _position;

  String get position => _position;

  set position(String value) {
    _position = value;
    notifyListeners();
  }

  /// Company location
  TextEditingController _companyLocationTextController;

  TextEditingController get companyLocationTextController =>
      _companyLocationTextController;

  set companyLocationTextController(TextEditingController value) {
    _companyLocationTextController = value;
    notifyListeners();
  }

  FocusNode _companyLocationFocusNode;

  FocusNode get companyLocationFocusNode => _companyLocationFocusNode;

  set companyLocationFocusNode(FocusNode value) {
    _companyLocationFocusNode = value;
    notifyListeners();
  }

  String _companyLocation;

  String get companyLocation => _companyLocation;

  set companyLocation(String value) {
    _companyLocation = value;
    notifyListeners();
  }

  /// for blocking clicks when signing up
  bool _isWaiting;

  bool get isWaiting => _isWaiting;

  set isWaiting(bool value) {
    _isWaiting = value;
    notifyListeners();
  }
}
