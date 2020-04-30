import 'package:easy_cv/models/story.dart';
import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/ui/pages/add_story_page.dart';
import 'package:easy_cv/ui/widgets/profile_avatar.dart';
import 'package:easy_cv/ui/widgets/profile_info_list.dart';
import 'package:easy_cv/ui/widgets/section_item.dart';
import 'package:easy_cv/ui/widgets/section_title.dart';
import 'package:easy_cv/ui/widgets/tappable.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/view_models/app_view_model.dart';
import 'package:easy_cv/view_models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfilePage extends StatefulWidget {
  final String profileName;
  final AppViewModel viewModel;

  const ProfilePage({
    Key key,
    this.profileName,
    this.viewModel,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    final username = widget.profileName ?? widget.viewModel?.user?.uid;
    profileViewModel.loadProfile(username).then((_) {
      profileViewModel.loadExperience();
      profileViewModel.loadEducation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProfileViewModel>(
      model: profileViewModel,
      child: ScopedModelDescendant<ProfileViewModel>(
        builder: (BuildContext context, _, ProfileViewModel model) {
          bool _isNotLoggedIn = widget.viewModel == null ||
              widget.viewModel.user?.uid != model.user?.uid;
          return Scaffold(
            floatingActionButton: _buildFab(context, model, _isNotLoggedIn),
            backgroundColor: Colors.white,
            body: _buildBody(context, model, _isNotLoggedIn),
          );
        },
      ),
    );
  }

  FloatingActionButton _buildFab(
      BuildContext context, ProfileViewModel model, bool isNotLoggedIn) {
    if (isNotLoggedIn) {
      return null;
    }
    return FloatingActionButton(
      onPressed: () {
        context.navigator.push(
          AddStoryPage().route(context),
        );
      },
      child: Icon(Icons.add),
    );
  }

  Widget _buildBody(
      BuildContext context, ProfileViewModel model, bool isNotLoggedIn) {
    if (model.user == null) {
      return SizedBox();
    }
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizeInfo) {
        if (sizeInfo.isMobile) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildProfileSummary(
                  context,
                  model,
                  isNotLoggedIn,
                ),
                _buildSections(
                  context,
                  model,
                  isNotLoggedIn,
                ),
              ],
            ).wrapWithContainer(maxWidth: sizeInfo.screenSize.width),
          );
        }
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildProfileSummary(
                context,
                model,
                isNotLoggedIn,
              ).wrapWithContainer(maxWidth: 300.0),
              _buildSpacer(sizeInfo),
              SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: _buildSections(context, model, isNotLoggedIn),
              ).expand(),
            ],
          ),
        ).wrapWithContainer(maxWidth: 1024).center();
      },
    );
  }

  Widget _buildSections(
      BuildContext context, ProfileViewModel model, bool isNotLoggedIn) {
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
        ).wrapEditor(context, ProfileEnum.intro, isNotLoggedIn),
      ]
        ..addAll(_getExperienceSection(context, model, isNotLoggedIn))
        ..addAll(_getEducationSection(context, model, isNotLoggedIn)),
    ).addPaddingVertical(3);
  }

  List<Widget> _getExperienceSection(
      BuildContext context, ProfileViewModel model, isNotLoggedIn) {
    if (model.experience == null) {
      return [];
    }
    return [
      SectionTitle("Work Experience").addMarginTop(5),
    ]..add(_buildStories(context, model.experience, isNotLoggedIn));
  }

  List<Widget> _getEducationSection(
      BuildContext context, ProfileViewModel model, isNotLoggedIn) {
    if (model.education == null) {
      return [];
    }
    return [
      SectionTitle("Education").addMarginTop(5),
    ]..add(_buildStories(context, model.education, isNotLoggedIn));
  }

  Widget _buildProfileSummary(
      BuildContext context, ProfileViewModel model, bool isNotLoggedIn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ProfileAvatar(
          size: 150,
          user: model.user,
          showRing: false,
        )
            .wrapEditor(context, ProfileEnum.avatar, isNotLoggedIn)
            .addMarginTop(6),
        Text(
          "${model.user.firstName} ${model.user.lastName}",
          style: context.textTheme.headline4.copyWith(
            color: context.theme.primaryColor.withOpacity(0.87),
            fontWeight: FontWeight.bold,
          ),
        ).wrapEditor(context, ProfileEnum.name, isNotLoggedIn).addMarginTop(3),
        Text(
          "${model.user.bio}",
          style: context.textTheme.headline6.copyWith(
            color: context.theme.primaryColor.withOpacity(0.87),
            fontWeight: FontWeight.w400,
          ),
        ).wrapEditor(context, ProfileEnum.bio, isNotLoggedIn).addMarginTop(),
        ProfileInfoList(
          user: model.user,
        ).addMarginTop(4),
      ],
    );
  }

  Widget _buildSpacer(SizingInformation sizeInfo) {
    if (sizeInfo.isTablet) {
      return const SizedBox(width: 16.0);
    }
    return const SizedBox(width: 64.0);
  }

  Widget _buildStories(
      BuildContext context, List<Story> stories, isNotLoggedIn) {
    final List<Widget> items = [];
    final length = stories.length;
    for (int position = 0; position < length; position++) {
      items.add(SectionItem(
        title: stories[position].title,
        label: stories[position].label,
        degree: stories[position].degree,
        company: stories[position].company,
        location: stories[position].location,
        summary: stories[position].summary,
        startDate: stories[position].startDate,
        endDate: stories[position].endDate,
        isCurrent: stories[position].isCurrent,
        showDivider: position != 0,
        isNotLoggedIn: isNotLoggedIn,
      ));
    }
    return Column(
      children: items,
    );
  }
}

extension WidgetExtension on Widget {
  Widget wrapEditor(
      BuildContext context, ProfileEnum type, bool isNotLoggedIn) {
    if (isNotLoggedIn) {
      return this;
    }
    return Tappable(
      onTap: () {
        Fluttertoast.showToast(
          msg: "Long press to edit!",
          gravity: ToastGravity.TOP,
          backgroundColor: context.theme.primaryColor,
          textColor: Colors.white.withOpacity(0.87),
        );
      },
      onLongPress: () {
        // edit
      },
      child: this,
    );
  }
}

enum ProfileEnum {
  avatar,
  name,
  bio,
  location,
  github,
  website,
  intro,
  experience,
  education,
}
