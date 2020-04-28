import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BeginViewModel extends Model {
  BeginViewModel() {
    mainPageController = PageController();
    firstNameTextController = TextEditingController();
    currentPage = 0;
    firstName = "";
    lastName = "";
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
}
