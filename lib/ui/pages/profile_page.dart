import 'package:easy_cv/models/story.dart';
import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/ui/widgets/profile_avatar.dart';
import 'package:easy_cv/ui/widgets/profile_info_list.dart';
import 'package:easy_cv/ui/widgets/section_item.dart';
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
    profileViewModel.loadProfile(widget.profileName).then((_) {
      profileViewModel.loadExperience();
      profileViewModel.loadEducation();
    });
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
            return Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildProfileSummary(
                    context,
                    model,
                  ).wrapWithContainer(maxWidth: 300.0),
                  _buildSpacer(),
                  SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: _buildSections(context, model),
                  ).expand(),
                ],
              ),
            ).wrapWithContainer(maxWidth: 1024).center();
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
      ]
        ..addAll(_getExperienceSection(context, model))
        ..addAll(_getEducationSection(context, model)),
    ).addPaddingVertical(3);
  }

  List<Widget> _getExperienceSection(
      BuildContext context, ProfileViewModel model) {
    if (model.experience == null) {
      return [];
    }
    return [
      SectionTitle("Work Experience").addPaddingVertical(3).addMarginTop(),
    ]..add(_buildStories(context, model.experience));
  }

  List<Widget> _getEducationSection(
      BuildContext context, ProfileViewModel model) {
    if (model.education == null) {
      return [];
    }
    return [
      SectionTitle("Education").addPaddingVertical(3).addMarginTop(),
    ]..add(_buildStories(context, model.education));
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

  Widget _buildStories(BuildContext context, List<Story> stories) {
    final List<Widget> items = [];
    final length = stories.length;
    for (int position = 0; position < length; position++) {
      items.add(SectionItem(
        title: stories[position].title,
        label: stories[position].label,
        degree: stories[position].degree,
        company: stories[position].company,
        location: stories[position].location,
        startDate: stories[position].startDate,
        endDate: stories[position].endDate,
        isCurrent: stories[position].isCurrent,
        showDivider: position != 0,
      ));
    }
    return Column(
      children: items,
    );
  }
}
