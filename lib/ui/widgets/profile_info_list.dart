import 'package:easy_cv/models/dsc_user.dart';
import 'package:easy_cv/ui/widgets/profile_info_item.dart';
import 'package:flutter/material.dart';

class ProfileInfoList extends StatelessWidget {
  final DscUser user;

  const ProfileInfoList({
    Key key,
    this.user,
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
          icon: Icons.email,
          title: user.location,
        ),
        ProfileInfoItem(
          icon: Icons.link,
          title: user.github,
        ),
        ProfileInfoItem(
          icon: Icons.link,
          title: user.website,
        ),
      ],
    );
  }
}
