import 'package:easy_cv/models/dsc_user.dart';
import 'package:easy_cv/services/dsc_portal_api_service.dart';
import 'package:easy_cv/singleton_instances.dart';
import 'package:flutter/foundation.dart';
import 'package:scoped_model/scoped_model.dart';

class AppViewModel extends Model {
  final DscPortalApiService apiSvc;

  AppViewModel({@required this.apiSvc});

  /// Authorization
  DscUser _user;

  DscUser get user => _user;

  set user(DscUser value) {
    _user = value;
    notifyListeners();
  }

  bool get isSignedIn => _user != null;

  Future<bool> loadUser([String uid]) async {
    final _uid = uid ?? (await firebaseAuth.currentUser())?.uid;
    if (_uid != null) {
      user = await apiSvc?.getUser(_uid);
    }
    return user != null;
  }

  Future<bool> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
    String location,
    String bio,
    String username,
    String intro, {
    Function onError,
  }) async {
    try {
      final result = await apiSvc?.signUpWithEmailPassword(email, password);
      user = await apiSvc?.updateUser(
          result.user, firstName, lastName, location, bio, username, intro);
    } catch (error) {
      if (onError != null) {
        onError(error);
      }
    }
    return user != null;
  }

  Future<bool> signInWithEmailPassword(
    String email,
    String password, {
    Function onError,
  }) async {
    try {
      final result = await apiSvc?.signInWithEmailPassword(email, password);
      await loadUser(result.user.uid);
    } catch (error) {
      if (onError != null) {
        onError(error);
      }
    }
    return user != null;
  }

  Future<bool> signOut({Function onError}) async {
    try {
      await apiSvc?.signOut();
      user = null;
    } catch (error) {
      if (onError != null) {
        onError(error.message);
      }
    }
    return user == null;
  }
}
