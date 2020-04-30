import 'package:easy_cv/models/dsc_user.dart';
import 'package:easy_cv/models/story.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class InterfaceDscPortalApi {
  Future<AuthResult> signInWithEmailPassword(String email, String password);

  Future<AuthResult> signUpWithEmailPassword(String email, String password);

  Future<DscUser> getUser(String uid);

  Future<String> getUidFromUsername(String username);

  Future<DscUser> updateUser(
    FirebaseUser user,
    String firstName,
    String lastName,
    String location,
    String bio,
    String username,
    String intro,
  );

  Future<List<Story>> getUserExperience(String uid);

  Future<List<Story>> getUserEducation(String uid);

  Future<void> signOut();
}
