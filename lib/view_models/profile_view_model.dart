import 'package:easy_cv/models/dsc_user.dart';
import 'package:easy_cv/models/story.dart';
import 'package:easy_cv/services/dsc_portal_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileViewModel extends Model {
  final DscPortalApiService apiSvc;

  ProfileViewModel({@required this.apiSvc});

  DscUser _user;

  DscUser get user => _user;

  set user(DscUser value) {
    _user = value;
    notifyListeners();
  }

  List<Story> _experience;

  List<Story> get experience => _experience;

  set experience(List<Story> value) {
    _experience = value;
    notifyListeners();
  }

  List<Story> _education;

  List<Story> get education => _education;

  set education(List<Story> value) {
    _education = value;
    notifyListeners();
  }

  Future<bool> loadProfile([String username]) async {
    try {
      if (username != null) {
        final userId = await apiSvc?.getUidFromUsername(username);
        user = await apiSvc?.getUser(userId);
      }
    } catch (error) {
      user = null;
    }
    return user != null;
  }

  Future<bool> loadExperience([String uid]) async {
    try {
      final _uid = uid ?? user.uid;
      if (_uid != null) {
        experience = await apiSvc?.getUserExperience(_uid);
      }
    } catch (error) {
      experience = null;
    }
    return experience != null;
  }

  Future<bool> loadEducation([String uid]) async {
    try {
      final _uid = uid ?? user.uid;
      if (_uid != null) {
        education = await apiSvc?.getUserEducation(_uid);
      }
    } catch (error) {
      education = null;
    }
    return education != null;
  }

  Future<bool> updateProfile() async {
    try {
      await apiSvc?.updateProfile(user);
      return true;
    } catch (error) {
      return false;
    }
  }
}
