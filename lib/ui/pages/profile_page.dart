import 'package:easy_cv/models/story.dart';
import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/ui/pages/add_story_page.dart';
import 'package:easy_cv/ui/pages/story_edit_page.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:share/share.dart';

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
      profileViewModel.refreshAvatarLink();
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
            appBar: _buildAppBar(context, model, _isNotLoggedIn),
            floatingActionButton: _buildFab(context, model, _isNotLoggedIn),
            backgroundColor: Colors.white,
            body: _buildBody(context, model, _isNotLoggedIn),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(
      BuildContext context, ProfileViewModel model, bool isNotLoggedIn) {
    if (isNotLoggedIn) {
      return null;
    }
    final cvUrl = "https://easycv.simonit.dev/#/${model.user.username}";
    return AppBar(
      title: Column(
        children: <Widget>[
          Text(
            "Your profile is public at:",
            style: context.textTheme.subtitle1.copyWith(
              color: Colors.white.withOpacity(0.6),
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            cvUrl,
            style: context.textTheme.subtitle1.copyWith(
              color: Colors.white.withOpacity(0.87),
              fontSize: 14.0,
            ),
          ).addPaddingVertical()
        ],
      ),
      actions: <Widget>[
        Tappable(
          onTap: () {
            Share.share(cvUrl);
          },
          child: Icon(Icons.share).addPadding(2),
        ),
      ],
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
        ).wrapEditor(context, model, ProfileEnum.intro, isNotLoggedIn),
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
    ]..add(_buildStories(context, model, StoryType.company, isNotLoggedIn));
  }

  List<Widget> _getEducationSection(
      BuildContext context, ProfileViewModel model, isNotLoggedIn) {
    if (model.education == null) {
      return [];
    }
    return [
      SectionTitle("Education").addMarginTop(5),
    ]..add(_buildStories(context, model, StoryType.school, isNotLoggedIn));
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
            .wrapEditor(context, model, ProfileEnum.avatar, isNotLoggedIn)
            .addMarginTop(6),
        Text(
          "${model.user.firstName} ${model.user.lastName}",
          style: context.textTheme.headline4.copyWith(
            color: context.theme.primaryColor.withOpacity(0.87),
            fontWeight: FontWeight.bold,
          ),
        )
            .wrapEditor(context, model, ProfileEnum.name, isNotLoggedIn)
            .addMarginTop(3),
        Text(
          "${model.user.bio}",
          style: context.textTheme.headline6.copyWith(
            color: context.theme.primaryColor.withOpacity(0.87),
            fontWeight: FontWeight.w400,
          ),
        )
            .wrapEditor(context, model, ProfileEnum.bio, isNotLoggedIn)
            .addMarginTop(),
        ProfileInfoList(
          model: model,
          isNotLoggedIn: isNotLoggedIn,
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

  Widget _buildStories(BuildContext context, ProfileViewModel model,
      StoryType storyType, isNotLoggedIn) {
    final List<Widget> items = [];
    final stories = (storyType == StoryType.school).ifTrue(
      model.education,
      model.experience,
    );
    final length = stories.length;
    for (int position = 0; position < length; position++) {
      items.add(
        SectionItem(
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
        ).wrapEditor(
          context,
          model,
          (storyType == StoryType.school).ifTrue(
            ProfileEnum.education,
            ProfileEnum.experience,
          ),
          isNotLoggedIn,
          story: stories[position],
        ),
      );
    }
    return Column(
      children: items,
    );
  }
}

extension WidgetExtension on Widget {
  Widget wrapEditor(
    BuildContext context,
    ProfileViewModel model,
    ProfileEnum type,
    bool isNotLoggedIn, {
    Story story,
  }) {
    if (isNotLoggedIn) {
      return this;
    }
    return Tappable(
      onTap: () {
        Fluttertoast.showToast(
          msg: "Long press to edit!",
          gravity: ToastGravity.CENTER,
          backgroundColor: context.theme.primaryColor.withOpacity(0.9),
          textColor: Colors.white,
        );
      },
      onLongPress: () {
        switch (type) {
          case ProfileEnum.bio:
            context.showEditDialog(
              label: "YOUR SHORT BIO",
              text: model.user.bio ?? "",
              yesAction: (String text) {
                final user = model.user;
                user.bio = text;
                model.user = user;
                model.updateProfile();
              },
            );
            break;
          case ProfileEnum.intro:
            context.showEditDialog(
              label: "YOUR PROFESSIONAL SUMMARY",
              text: model.user.intro ?? "",
              yesAction: (String text) {
                final user = model.user;
                user.intro = text;
                model.user = user;
                model.updateProfile();
              },
            );
            break;
          case ProfileEnum.name:
            context.showEditDialog(
              label: "YOUR FIRST NAME",
              text: model.user.firstName ?? "",
              yesAction: (String firstName) async {
                await context.showEditDialog(
                  label: "YOUR LAST NAME",
                  text: model.user.lastName ?? "",
                  yesAction: (String lastName) {
                    final user = model.user;
                    user.firstName = firstName;
                    user.lastName = lastName;
                    model.user = user;
                    model.updateProfile();
                  },
                );
              },
            );
            break;
          case ProfileEnum.github:
            context.showEditDialog(
              label: "YOUR GITHUB LINK",
              text: model.user.github ?? "",
              yesAction: (String text) {
                final user = model.user;
                user.github = text;
                model.user = user;
                model.updateProfile();
              },
            );
            break;
          case ProfileEnum.location:
            context.showEditDialog(
              label: "YOUR LOCATION",
              text: model.user.location ?? "",
              yesAction: (String text) {
                final user = model.user;
                user.location = text;
                model.user = user;
                model.updateProfile();
              },
            );
            break;
          case ProfileEnum.website:
            context.showEditDialog(
              label: "YOUR WEBSITE",
              text: model.user.website ?? "",
              yesAction: (String text) {
                final user = model.user;
                user.website = text;
                model.user = user;
                model.updateProfile();
              },
            );
            break;
          case ProfileEnum.education:
            storyEditViewModel.initSchool(story);
            context.navigator.push(
              StoryEditPage(
                type: StoryType.school,
                profileModel: model,
              ).route(context),
            );
            break;
          case ProfileEnum.experience:
            storyEditViewModel.initCompany(story);
            context.navigator.push(
              StoryEditPage(
                type: StoryType.company,
                profileModel: model,
              ).route(context),
            );
            break;
          case ProfileEnum.avatar:
            _handleAvatarEdit(context, model);
            break;
          default:
            break;
        }
      },
      child: this,
    );
  }

  _handleAvatarEdit(BuildContext context, ProfileViewModel model) async {
    try {
      await ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
        Fluttertoast.showToast(
          msg: "Uploading photo...",
          gravity: ToastGravity.CENTER,
          backgroundColor: context.theme.primaryColor.withOpacity(0.9),
          textColor: Colors.white,
        );
        firebaseStorage
            .ref()
            .child("profile_photos/${model.user.uid}")
            .putFile(file)
            .onComplete
            .then((value) {
          value.ref.getDownloadURL().then((url) {
            final user = model.user;
            user.profilePicUrl = url;
            model.user = user;
            model.updateProfile();
          });
        });
      }, onError: (error) {
        Fluttertoast.showToast(
          msg: "Cannot select file!",
          gravity: ToastGravity.CENTER,
          backgroundColor: context.theme.primaryColor.withOpacity(0.9),
          textColor: Colors.white,
        );
      });
    } catch (error) {
      print(error);
    }
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
