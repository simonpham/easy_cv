import 'package:easy_cv/ui/pages/begin_page.dart';
import 'package:easy_cv/ui/widgets/new_item_badge.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/view_models/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AddStoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppViewModel>(
      builder: (BuildContext context, _, AppViewModel model) {
        if (model.isSignedIn) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text("Add a new item"),
            ),
            backgroundColor: Colors.indigo,
            body: Container(
              child: Column(
                children: <Widget>[
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    children: <Widget>[
                      NewItemBadge(
                        icon: Icons.school,
                        title: "School",
                      ),
                      NewItemBadge(
                        icon: Icons.work,
                        title: "Workplace",
                      ),
                      NewItemBadge(
                        icon: Icons.link,
                        title: "Website",
                      ),
                      NewItemBadge(
                        icon: Icons.link,
                        title: "GitHub",
                      ),
                    ],
                  ).expand(),
                  Text(
                    "Your profile is public at:",
                    style: context.textTheme.subtitle1.copyWith(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "https://easycv.simonit.dev/#/${model.user.username}",
                    style: context.textTheme.subtitle1.copyWith(
                      color: Colors.white.withOpacity(0.87),
                      fontSize: 14.0,
                    ),
                  ).addMarginTop(1),
                ],
              ),
            ).addPaddingHorizontal(2).addPaddingVertical(2).wrapSafeArea(),
          );
        }
        return BeginPage();
      },
    );
  }
}
