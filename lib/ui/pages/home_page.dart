import 'package:easy_cv/ui/pages/begin_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/view_models/app_view_model.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home_page";

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppViewModel>(
      builder: (BuildContext context, _, AppViewModel model) {
        if (model.isSignedIn) {
          return Container(
            color: context.theme.primaryColor,
          );
        }
        return BeginPage();
      },
    );
  }
}
