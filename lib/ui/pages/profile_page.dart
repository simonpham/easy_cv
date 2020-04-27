import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/ui/widgets/profile_avatar.dart';
import 'package:easy_cv/ui/widgets/profile_info_list.dart';
import 'package:easy_cv/ui/widgets/section_title.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/view_models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfilePage extends StatefulWidget {
  final String profileName;

  const ProfilePage({Key key, this.profileName}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    profileViewModel.loadProfile(widget.profileName);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProfileViewModel>(
      model: profileViewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ScopedModelDescendant<ProfileViewModel>(
          builder: (BuildContext context, _, ProfileViewModel model) {
            if (model.user == null) {
              return SizedBox();
            }
            return SingleChildScrollView(
              child: Container(
                child: Row(
                  children: <Widget>[
                    _buildProfileSummary(
                      context,
                      model,
                    ).wrapWithContainer(maxWidth: 300.0),
                    _buildSpacer(),
                    _buildSections(context, model).expand(),
                  ],
                ),
              ).wrapWithContainer(maxWidth: 1024).center(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSections(BuildContext context, ProfileViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SectionTitle("Professional Summary").addPaddingVertical(3),
        Text(
          "${model.user.intro}",
          style: context.textTheme.subtitle1.copyWith(
            color: context.theme.primaryColor.withOpacity(0.87),
            fontWeight: FontWeight.w400,
          ),
        ),
        SectionTitle("Work Experience").addPaddingVertical(3).addMarginTop(),
        SectionTitle("Education").addPaddingVertical(3).addMarginTop(),
      ],
    );
  }

  Widget _buildProfileSummary(BuildContext context, ProfileViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ProfileAvatar(
          size: 150,
          user: model.user,
          showRing: false,
        ).addMarginTop(6),
        Text(
          "${model.user.firstName} ${model.user.lastName}",
          style: context.textTheme.headline4.copyWith(
            color: context.theme.primaryColor.withOpacity(0.87),
            fontWeight: FontWeight.bold,
          ),
        ).addMarginTop(3),
        Text(
          "${model.user.bio}",
          style: context.textTheme.headline6.copyWith(
            color: context.theme.primaryColor.withOpacity(0.87),
            fontWeight: FontWeight.w500,
          ),
        ).addMarginTop(),
        ProfileInfoList(
          user: model.user,
        ).addMarginTop(4),
      ],
    );
  }

  Widget _buildSpacer() {
    return const SizedBox(width: 64.0);
  }
}
