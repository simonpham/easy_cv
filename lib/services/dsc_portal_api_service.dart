import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_cv/interfaces/dsc_portal_api_interface.dart';
import 'package:easy_cv/models/dsc_user.dart';
import 'package:easy_cv/singleton_instances.dart';

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
    String name,
    String username,
  ) async {
    final CollectionReference ref = firestore.collection('users');

    final newData = {
      'uid': user.uid,
      'name': name ?? user.displayName ?? "N/A",
      'profile_pic_url': user.photoUrl ?? "",
      'email': user.email,
      'username': username ?? user.email.split("@").first,
    };
    await ref.document(user.uid).setData(newData, merge: true);

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
}
