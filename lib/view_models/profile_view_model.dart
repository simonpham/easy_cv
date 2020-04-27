import 'package:easy_cv/models/dsc_user.dart';
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
}
