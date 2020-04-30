import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:easy_cv/interfaces/dsc_portal_api_interface.dart';
import 'package:easy_cv/models/dsc_user.dart';
import 'package:easy_cv/models/story.dart';
import 'package:easy_cv/singleton_instances.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DscPortalApiService implements InterfaceDscPortalApi {
  final _endpoint = "https://api.app/";
  final Dio _dio = Dio();

  static final DscPortalApiService _internal = DscPortalApiService.internal();

  factory DscPortalApiService() => _internal;

  DscPortalApiService.internal();

  @override
  Future<AuthResult> signInWithEmailPassword(String email, String password) {
    final result = firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result;
  }

  @override
  Future<AuthResult> signUpWithEmailPassword(String email, String password) {
    final result = firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result;
  }

  @override
  Future<DscUser> updateUser(
    FirebaseUser user,
    String firstName,
    String lastName,
    String location,
    String bio,
    String username,
    String intro,
    Story school,
    Story company,
  ) async {
    final CollectionReference ref = firestore.collection('users');

    /// Update user basic info.
    final newData = {
      'uid': user.uid,
      'profile_pic_url': user.photoUrl ?? "",
      'email': user.email,
      'username': username ?? user.email.split("@").first,
      'first_name': firstName,
      'last_name': lastName,
      'location': location,
      'bio': bio,
      'intro': intro,
    };
    await ref.document(user.uid).setData(newData, merge: true);

    /// Update education
    await firestore.collection("users/${user.uid}/education").add({
      'company': school.company,
      'title': school.degree,
      'location': school.location,
    });

    /// Update experience
    await firestore.collection("users/${user.uid}/experience").add({
      'company': company.company,
      'title': company.title,
      'location': company.location,
    });

    /// Update CV url
    await firestore.collection('user_urls').document(username).setData({
      "uid": user.uid,
    });

    return getUser(user.uid);
  }

  @override
  Future<bool> updateProfile(DscUser user) async {
    final CollectionReference ref = firestore.collection('users');
    final newData = user.toMap();
    await ref.document(user.uid).setData(newData, merge: true);
    return true;
  }

  @override
  Future<bool> updateSchool(DscUser user, Story school) async {
    await firestore
        .collection("users/${user.uid}/education")
        .document(school.id)
        .setData(
          school.toMap(),
          merge: true,
        );
  }

  @override
  Future<bool> updateCompany(DscUser user, Story company) async {
    await firestore
        .collection("users/${user.uid}/experience")
        .document(company.id)
        .setData(
          company.toMap(),
          merge: true,
        );
  }

  @override
  Future<bool> addSchool(DscUser user, Story school) async {
    await firestore.collection("users/${user.uid}/education").add(
          school.toMap(),
        );
  }

  @override
  Future<bool> addCompany(DscUser user, Story company) async {
    await firestore.collection("users/${user.uid}/experience").add(
          company.toMap(),
        );
  }

  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  @override
  Future<DscUser> getUser(String uid) async {
    final CollectionReference ref = firestore.collection('users');
    return DscUser.fromMap((await ref.document(uid).get()).data);
  }

  @override
  Future<String> getUidFromUsername(String username) async {
    final snapshot =
        await firestore.collection('user_urls').document(username).get();
    return snapshot.data['uid'];
  }

  @override
  Future<List<Story>> getUserExperience(String uid) async {
    final snapshot =
        await firestore.collection('users/$uid/experience').getDocuments();
    final List<Story> items = [];
    snapshot.documents.forEach((element) {
      final item = Story.fromMap(element.data);
      item.id = element.documentID;

      items.add(
        item,
      );
    });
    items.sort((Story a, Story b) => (b?.startDate ?? 0) - (a?.startDate ?? 0));
    return items;
  }

  @override
  Future<List<Story>> getUserEducation(String uid) async {
    final snapshot =
        await firestore.collection('users/$uid/education').getDocuments();
    final List<Story> items = [];
    snapshot.documents.forEach((element) {
      final item = Story.fromMap(element.data);
      item.id = element.documentID;

      items.add(
        item,
      );
    });
    items.sort((Story a, Story b) => (b?.startDate ?? 0) - (a?.startDate ?? 0));
    return items;
  }
}
