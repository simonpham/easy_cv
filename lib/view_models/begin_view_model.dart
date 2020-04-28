import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BeginViewModel extends Model {
  BeginViewModel() {
    mainPageController = PageController();
  }

  PageController _mainPageController;

  PageController get mainPageController => _mainPageController;

  set mainPageController(PageController value) {
    _mainPageController = value;
    notifyListeners();
  }
}
