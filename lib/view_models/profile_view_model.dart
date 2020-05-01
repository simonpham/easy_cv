import 'package:easy_cv/models/dsc_user.dart';
import 'package:easy_cv/models/story.dart';
import 'package:easy_cv/services/dsc_portal_api_service.dart';
import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/ui/pages/story_edit_page.dart';
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

  Future<String> refreshAvatarLink() async {
    final ref = firebaseStorage.ref().child("profile_photos/${user.uid}");
    final url = await ref.getDownloadURL();
    user.profilePicUrl = url;
    await this.updateProfile();
    notifyListeners();
    return url;
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

  Future<bool> updateSchool(Story school) async {
    try {
      final schoolToUpdate = education.firstWhere((item) {
        return item.id == school.id;
      }, orElse: () {
        return null;
      });
      if (schoolToUpdate == null) {
        // add new school
        final success = await apiSvc?.addSchool(user, school);
        if (success == true) {
          education.insert(0, school);
          notifyListeners();
        }
      } else {
        // update current school
        final success = await apiSvc?.updateSchool(user, school);
        if (success == true) {
          education.removeWhere((item) => item.id == school.id);
          education.insert(0, school);
          notifyListeners();
        }
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> updateCompany(Story company) async {
    try {
      final companyToUpdate = experience.firstWhere((item) {
        return item.id == company.id;
      }, orElse: () {
        return null;
      });
      if (companyToUpdate == null) {
        // add new school
        final success = await apiSvc?.addCompany(user, company);
        if (success == true) {
          experience.insert(0, company);
          notifyListeners();
        }
      } else {
        // update current school
        final success = await apiSvc?.updateCompany(user, company);
        if (success == true) {
          experience.removeWhere((item) => item.id == company.id);
          experience.insert(0, company);
          notifyListeners();
        }
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> deleteStory(Story story, StoryType storyType) async {
    try {
      final success = await apiSvc?.deleteStory(user, story, storyType);
      if (success == true) {
        if (storyType == StoryType.company) {
          experience.removeWhere((item) => story.id == item.id);
        } else {
          education.removeWhere((item) => story.id == item.id);
        }
        notifyListeners();
      }
      return true;
    } catch (error) {
      return false;
    }
  }
}
