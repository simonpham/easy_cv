import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/ui/pages/begin_page.dart';
import 'package:easy_cv/ui/pages/story_edit_page.dart';
import 'package:easy_cv/ui/widgets/new_item_badge.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/view_models/app_view_model.dart';
import 'package:easy_cv/view_models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AddStoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppViewModel>(
      builder: (BuildContext context, _, AppViewModel appModel) {
        if (appModel.isSignedIn) {
          return ScopedModel<ProfileViewModel>(
            model: profileViewModel,
            child: ScopedModelDescendant<ProfileViewModel>(
              builder:
                  (BuildContext context, Widget child, ProfileViewModel model) {
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
                              onTap: () {
                                storyEditViewModel.reset();
                                context.navigator.push(
                                  StoryEditPage(
                                    profileModel: model,
                                    type: StoryType.school,
                                  ).route(context),
                                );
                              },
                            ),
                            NewItemBadge(
                              icon: Icons.work,
                              title: "Workplace",
                              onTap: () {
                                storyEditViewModel.reset();
                                context.navigator.push(
                                  StoryEditPage(
                                    profileModel: model,
                                    type: StoryType.company,
                                  ).route(context),
                                );
                              },
                            ),
                            NewItemBadge(
                              icon: Icons.link,
                              title: "Website",
                              onTap: () {
                                context.showEditDialog(
                                  title: "Add a link to your website",
                                  label: "YOUR WEBSITE",
                                  text: model.user.website ?? "",
                                  yesAction: (String website) {
                                    final user = model.user;
                                    user.website = website;
                                    model.user = user;
                                    model.updateProfile();
                                  },
                                );
                              },
                            ),
                            NewItemBadge(
                              icon: Icons.link,
                              title: "GitHub",
                              onTap: () {
                                context.showEditDialog(
                                  title: "Add a link to your GitHub profile",
                                  label: "YOUR GITHUB",
                                  text: model.user.github ?? "",
                                  yesAction: (String website) {
                                    final user = model.user;
                                    user.github = website;
                                    model.user = user;
                                    model.updateProfile();
                                  },
                                );
                              },
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
                  )
                      .addPaddingHorizontal(2)
                      .addPaddingVertical(2)
                      .wrapSafeArea(),
                );
              },
            ),
          );
        }
        return BeginPage();
      },
    );
  }
}
