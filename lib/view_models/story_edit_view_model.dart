import 'package:easy_cv/models/story.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StoryEditViewModel extends Model {
  StoryEditViewModel() {
    reset();
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

  /// Summary
  TextEditingController _summaryTextController;

  TextEditingController get summaryTextController => _summaryTextController;

  set summaryTextController(TextEditingController value) {
    _summaryTextController = value;
    notifyListeners();
  }

  FocusNode _summaryFocusNode;

  FocusNode get summaryFocusNode => _summaryFocusNode;

  set summaryFocusNode(FocusNode value) {
    _summaryFocusNode = value;
    notifyListeners();
  }

  String _summary;

  String get summary => _summary;

  set summary(String value) {
    _summary = value;
    notifyListeners();
  }

  /// Start date
  int _startDate;

  int get startDate => _startDate;

  set startDate(int value) {
    _startDate = value;
    notifyListeners();
  }

  /// End date
  int _endDate;

  int get endDate => _endDate;

  set endDate(int value) {
    _endDate = value;
    notifyListeners();
  }

  /// End date
  String _id;

  String get id => _id;

  set id(String value) {
    _id = value;
    notifyListeners();
  }

  void reset({
    String id,
    String location,
    String school,
    String major,
    String company,
    String position,
    String companyLocation,
    String summary,
    int startDate,
    int endDate,
  }) {
    this.id = id ?? "";

    locationTextController = TextEditingController(text: location ?? "");
    locationFocusNode = FocusNode();
    this.location = location ?? "";

    schoolTextController = TextEditingController(text: school ?? "");
    schoolFocusNode = FocusNode();
    this.school = school ?? "";

    majorTextController = TextEditingController(text: major ?? "");
    majorFocusNode = FocusNode();
    this.major = major ?? "";

    companyTextController = TextEditingController(text: company ?? "");
    companyFocusNode = FocusNode();
    this.company = company ?? "";

    positionTextController = TextEditingController(text: position ?? "");
    positionFocusNode = FocusNode();
    this.position = position ?? "";

    companyLocationTextController =
        TextEditingController(text: companyLocation ?? "");
    companyLocationFocusNode = FocusNode();
    this.companyLocation = companyLocation ?? "";

    summaryTextController = TextEditingController(text: summary ?? "");
    summaryFocusNode = FocusNode();
    this.summary = summary ?? "";

    this.startDate = startDate ?? DateTime.now().millisecondsSinceEpoch;
    this.endDate = endDate ?? DateTime.now().millisecondsSinceEpoch;
  }

  void initSchool(Story story) {
    reset(
      id: story.id,
      location: story.location,
      school: story.company,
      major: story.title,
      summary: story.summary,
      startDate: story.startDate,
      endDate: story.endDate,
    );
  }

  void initCompany(Story story) {
    reset(
      id: story.id,
      companyLocation: story.location,
      company: story.company,
      position: story.title,
      summary: story.summary,
      startDate: story.startDate,
      endDate: story.endDate,
    );
  }

  Story exportSchool() {
    return Story(
      id: id,
      location: location,
      company: school,
      title: major,
      summary: summary,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Story exportCompany() {
    return Story(
      id: id,
      location: companyLocation,
      company: company,
      title: position,
      summary: summary,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
