import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/ui/widgets/tappable.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/view_models/story_edit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class StoryEditPage extends StatelessWidget {
  final StoryType type;

  const StoryEditPage({
    Key key,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: storyEditViewModel,
      child: ScopedModelDescendant<StoryEditViewModel>(
        builder: (BuildContext context, _, StoryEditViewModel model) {
          const _maxNameLength = 32;
          return Scaffold(
            backgroundColor: context.theme.primaryColor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Text(type == StoryType.school ? "School" : "Workplace"),
              actions: <Widget>[
                FlatButton(
                  colorBrightness: Brightness.dark,
                  onPressed: () {},
                  child: Text("Save"),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[]
                  ..addAll(_buildSchool(context, model, _maxNameLength))
                  ..addAll(_buildWorkplace(context, model, _maxNameLength)),
              ),
            ).addPaddingHorizontal(2).addPaddingVertical().wrapSafeArea(),
          );
        },
      ),
    );
  }

  List<Widget> _buildSchool(
      BuildContext context, StoryEditViewModel model, int maxNameLength) {
    if (type == StoryType.company) {
      return [];
    }
    return [
      TextField(
        focusNode: model.schoolFocusNode,
        textInputAction: TextInputAction.next,
        onEditingComplete: () async {
          model.locationFocusNode.requestFocus();
        },
        controller: model.schoolTextController,
        decoration: InputDecoration(
          hintText: "What school did you attend?",
          errorText: "YOUR SCHOOL",
          errorStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          counterText: "${model.school?.length ?? 0}/$maxNameLength",
          counterStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        style: context.textTheme.headline6.copyWith(
          color: Colors.white.withOpacity(0.87),
        ),
        maxLength: maxNameLength,
        maxLengthEnforced: true,
        onChanged: (text) => model.school = model.schoolTextController.text,
      ).addMarginTop(),
      TextField(
        focusNode: model.locationFocusNode,
        textInputAction: TextInputAction.next,
        onEditingComplete: () async {
          model.majorFocusNode.requestFocus();
        },
        controller: model.locationTextController,
        decoration: InputDecoration(
          hintText: "Where is your school?",
          errorText: "YOUR SCHOOL'S LOCATION",
          errorStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          counterText: "${model.location?.length ?? 0}/$maxNameLength",
          counterStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        style: context.textTheme.headline6.copyWith(
          color: Colors.white.withOpacity(0.87),
        ),
        maxLength: maxNameLength,
        maxLengthEnforced: true,
        onChanged: (text) => model.location = model.locationTextController.text,
      ).addMarginTop(),
      TextField(
        focusNode: model.majorFocusNode,
        textInputAction: TextInputAction.next,
        onEditingComplete: () async {
          model.summaryFocusNode.requestFocus();
        },
        controller: model.majorTextController,
        decoration: InputDecoration(
          hintText: "Ex: Bachelor of Software Engineering",
          errorText: "YOUR CONCENTRATIONS",
          errorStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          counterText: "${model.major?.length ?? 0}/$maxNameLength",
          counterStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        style: context.textTheme.headline6.copyWith(
          color: Colors.white.withOpacity(0.87),
        ),
        maxLength: maxNameLength,
        maxLengthEnforced: true,
        onChanged: (text) => model.major = model.majorTextController.text,
      ).addMarginTop(),
      TextField(
        focusNode: model.summaryFocusNode,
        textInputAction: TextInputAction.done,
        onEditingComplete: () async {
          context.hideKeyboard();
//                    await _handleNextPage(context, model);
//                    model.companyFocusNode.requestFocus();
        },
        controller: model.summaryTextController,
        decoration: InputDecoration(
          hintText: "What did you achieve?",
          errorText: "ACHIEVEMENT SUMMARY",
          errorStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          counterText: "${model.summary?.length ?? 0}/$maxNameLength",
          counterStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        style: context.textTheme.headline6.copyWith(
          color: Colors.white.withOpacity(0.87),
        ),
        maxLength: maxNameLength,
        maxLengthEnforced: true,
        onChanged: (text) => model.summary = model.summaryTextController.text,
      ).addMarginTop(),
      Tappable(
        onTap: () {
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            minTime: DateTime(2018, 3, 5),
            maxTime: DateTime.now(),
            onConfirm: (DateTime date) {
              model.startDate = date.millisecondsSinceEpoch;
            },
            currentTime: DateTime.now(),
          );
        },
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: model.startDate.toString().toDate(),
            errorText: "START DATE",
            errorStyle: TextStyle(
              color: Colors.white.withOpacity(0.3),
            ),
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          style: context.textTheme.headline6.copyWith(
            color: Colors.white.withOpacity(0.87),
          ),
        ),
      ).addMarginTop(),
      Tappable(
        onTap: () {
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            minTime: DateTime(2018, 3, 5),
            maxTime: DateTime.now(),
            onConfirm: (DateTime date) {
              model.endDate = date.millisecondsSinceEpoch;
            },
            currentTime: DateTime.now(),
          );
        },
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: model.endDate.toString().toDate(),
            errorText: "END DATE",
            errorStyle: TextStyle(
              color: Colors.white.withOpacity(0.3),
            ),
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          style: context.textTheme.headline6.copyWith(
            color: Colors.white.withOpacity(0.87),
          ),
        ),
      ).addMarginTop(),
    ];
  }

  List<Widget> _buildWorkplace(
      BuildContext context, StoryEditViewModel model, int maxNameLength) {
    if (type == StoryType.school) {
      return [];
    }
    return [
      TextField(
        focusNode: model.companyFocusNode,
        textInputAction: TextInputAction.next,
        onEditingComplete: () async {
          model.positionFocusNode.requestFocus();
        },
        controller: model.companyTextController,
        decoration: InputDecoration(
          hintText: "Where have you worked?",
          errorText: "YOUR COMPANY",
          errorStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          counterText: "${model.company?.length ?? 0}/$maxNameLength",
          counterStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        style: context.textTheme.headline6.copyWith(
          color: Colors.white.withOpacity(0.87),
        ),
        maxLength: maxNameLength,
        maxLengthEnforced: true,
        onChanged: (text) => model.company = model.companyTextController.text,
      ).addMarginTop(),
      TextField(
        focusNode: model.positionFocusNode,
        textInputAction: TextInputAction.next,
        onEditingComplete: () async {
          model.companyLocationFocusNode.requestFocus();
        },
        controller: model.positionTextController,
        decoration: InputDecoration(
          hintText: "What is your job title?",
          errorText: "YOUR POSITION",
          errorStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          counterText: "${model.position?.length ?? 0}/$maxNameLength",
          counterStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        style: context.textTheme.headline6.copyWith(
          color: Colors.white.withOpacity(0.87),
        ),
        maxLength: maxNameLength,
        maxLengthEnforced: true,
        onChanged: (text) => model.position = model.positionTextController.text,
      ).addMarginTop(),
      TextField(
        focusNode: model.companyLocationFocusNode,
        textInputAction: TextInputAction.next,
        onEditingComplete: () async {
          model.summaryFocusNode.requestFocus();
        },
        controller: model.companyLocationTextController,
        decoration: InputDecoration(
          hintText: "My company is located in..",
          errorText: "YOUR COMPANY'S LOCATION",
          errorStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          counterText: "${model.companyLocation?.length ?? 0}/$maxNameLength",
          counterStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        style: context.textTheme.headline6.copyWith(
          color: Colors.white.withOpacity(0.87),
        ),
        maxLength: maxNameLength,
        maxLengthEnforced: true,
        onChanged: (text) =>
            model.companyLocation = model.companyLocationTextController.text,
      ).addMarginTop(),
      TextField(
        focusNode: model.summaryFocusNode,
        textInputAction: TextInputAction.done,
        onEditingComplete: () async {
          context.hideKeyboard();
        },
        controller: model.summaryTextController,
        decoration: InputDecoration(
          hintText: "What did you do?",
          errorText: "YOUR RESPONSIBILITY",
          errorStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          counterText: "${model.summary?.length ?? 0}/$maxNameLength",
          counterStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        style: context.textTheme.headline6.copyWith(
          color: Colors.white.withOpacity(0.87),
        ),
        maxLength: maxNameLength,
        maxLengthEnforced: true,
        onChanged: (text) => model.summary = model.summaryTextController.text,
      ).addMarginTop(),
      Tappable(
        onTap: () {
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            minTime: DateTime(2018, 3, 5),
            maxTime: DateTime.now(),
            onConfirm: (DateTime date) {
              model.startDate = date.millisecondsSinceEpoch;
            },
            currentTime: DateTime.now(),
          );
        },
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: model.startDate.toString().toDate(),
            errorText: "START DATE",
            errorStyle: TextStyle(
              color: Colors.white.withOpacity(0.3),
            ),
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          style: context.textTheme.headline6.copyWith(
            color: Colors.white.withOpacity(0.87),
          ),
        ),
      ).addMarginTop(),
      Tappable(
        onTap: () {
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            minTime: DateTime(2018, 3, 5),
            maxTime: DateTime.now(),
            onConfirm: (DateTime date) {
              model.endDate = date.millisecondsSinceEpoch;
            },
            currentTime: DateTime.now(),
          );
        },
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: model.endDate.toString().toDate(),
            errorText: "END DATE",
            errorStyle: TextStyle(
              color: Colors.white.withOpacity(0.3),
            ),
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          style: context.textTheme.headline6.copyWith(
            color: Colors.white.withOpacity(0.87),
          ),
        ),
      ).addMarginTop(),
    ];
  }
}

enum StoryType {
  school,
  company,
}
