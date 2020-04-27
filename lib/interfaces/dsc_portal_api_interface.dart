import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_cv/models/dsc_user.dart';

abstract class InterfaceDscPortalApi {
  Future<AuthResult> signInWithEmailPassword(String email, String password);

  Future<AuthResult> signUpWithEmailPassword(String email, String password);

  Future<DscUser> getUser(String uid);

  Future<String> getUidFromUsername(String username);

  Future<DscUser> updateUser(FirebaseUser user, String name, String username);

  Future<void> signOut();
}
