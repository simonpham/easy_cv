import 'package:easy_cv/ui/pages/begin_page.dart';
import 'package:easy_cv/ui/pages/profile_page.dart';
import 'package:easy_cv/view_models/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppViewModel>(
      builder: (BuildContext context, _, AppViewModel model) {
        if (model.isSignedIn) {
          return ProfilePage(
            profileName: model.user.username,
            viewModel: model,
          );
        }
        return BeginPage();
      },
    );
  }
}
