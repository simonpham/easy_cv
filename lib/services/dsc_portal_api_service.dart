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

    /// Update CV url
    await firestore.collection('user_urls').document(username).setData({
      "uid": user.uid,
    });

    return getUser(user.uid);
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

      if (items.isNotEmpty && items.first.startDate < item.startDate) {
        items.insert(0, item);
      } else {
        items.add(
          item,
        );
      }
    });
    return items;
  }

  @override
  Future<List<Story>> getUserEducation(String uid) async {
    final snapshot =
        await firestore.collection('users/$uid/education').getDocuments();
    final List<Story> items = [];
    snapshot.documents.forEach((element) {
      final item = Story.fromMap(element.data);

      if (items.isNotEmpty && items.first.startDate > item.startDate) {
        items.insert(0, item);
      } else {
        items.add(
          item,
        );
      }
    });
    return items;
  }
}
