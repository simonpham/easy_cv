import 'package:easy_cv/ui/pages/profile_page.dart';
import 'package:easy_cv/ui/widgets/profile_info_item.dart';
import 'package:easy_cv/view_models/profile_view_model.dart';
import 'package:flutter/material.dart';

class ProfileInfoList extends StatelessWidget {
  final ProfileViewModel model;
  final bool isNotLoggedIn;

  const ProfileInfoList({
    Key key,
    this.model,
    this.isNotLoggedIn = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ProfileInfoItem(
          icon: Icons.email,
          title: model?.user?.email,
          showDivider: false,
        ),
        ProfileInfoItem(
          icon: Icons.place,
          title: model?.user?.location,
        ).wrapEditor(context, model, ProfileEnum.location, isNotLoggedIn),
        ProfileInfoItem(
          icon: Icons.link,
          title: model?.user?.github,
        ).wrapEditor(context, model, ProfileEnum.github, isNotLoggedIn),
        ProfileInfoItem(
          icon: Icons.link,
          title: model?.user?.website,
        ).wrapEditor(context, model, ProfileEnum.website, isNotLoggedIn),
      ],
    );
  }
}
