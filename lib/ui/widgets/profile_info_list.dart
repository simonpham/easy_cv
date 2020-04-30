import 'package:easy_cv/models/dsc_user.dart';
import 'package:easy_cv/ui/pages/profile_page.dart';
import 'package:easy_cv/ui/widgets/profile_info_item.dart';
import 'package:flutter/material.dart';

class ProfileInfoList extends StatelessWidget {
  final DscUser user;
  final bool isNotLoggedIn;

  const ProfileInfoList({
    Key key,
    this.user,
    this.isNotLoggedIn = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ProfileInfoItem(
          icon: Icons.email,
          title: user.email,
          showDivider: false,
        ),
        ProfileInfoItem(
          icon: Icons.place,
          title: user.location,
        ).wrapEditor(context, ProfileEnum.location, isNotLoggedIn),
        ProfileInfoItem(
          icon: Icons.link,
          title: user.github,
        ).wrapEditor(context, ProfileEnum.github, isNotLoggedIn),
        ProfileInfoItem(
          icon: Icons.link,
          title: user.website,
        ).wrapEditor(context, ProfileEnum.website, isNotLoggedIn),
      ],
    );
  }
}
