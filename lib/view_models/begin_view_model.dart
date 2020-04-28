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
    firstName = "";
    lastName = "";
    location = "";
    email = "";
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
}
