import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_cv/services/dsc_portal_api_service.dart';
import 'package:easy_cv/view_models/app_view_model.dart';
import 'package:easy_cv/view_models/begin_view_model.dart';
import 'package:easy_cv/view_models/profile_view_model.dart';
import 'package:easy_cv/view_models/story_edit_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _chatApiService = DscPortalApiService();

final appViewModel = AppViewModel(apiSvc: _chatApiService);
final profileViewModel = ProfileViewModel(apiSvc: _chatApiService);
final beginViewModel = BeginViewModel();
final storyEditViewModel = StoryEditViewModel();

final firebaseAuth = FirebaseAuth.instance;
final firestore = Firestore.instance;
final firebaseStorage = FirebaseStorage.instance;

