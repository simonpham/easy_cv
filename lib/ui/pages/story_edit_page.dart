import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/view_models/story_edit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

final storyEditViewModel = StoryEditViewModel();

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
            body: Column(
              children: <Widget>[
                TextField(
                  focusNode: model.schoolFocusNode,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () async {
                    model.majorFocusNode.requestFocus();
                  },
                  controller: model.schoolTextController,
                  decoration: InputDecoration(
                    hintText: "What school did you attend?",
                    errorText: "YOUR SCHOOL",
                    errorStyle: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                    ),
                    counterText: "${model.school?.length ?? 0}/$_maxNameLength",
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
                  maxLength: _maxNameLength,
                  maxLengthEnforced: true,
                  onChanged: (text) =>
                      model.school = model.schoolTextController.text,
                ).addMarginTop(),
                TextField(
                  focusNode: model.majorFocusNode,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () async {
//                    await _handleNextPage(context, model);
//                    model.companyFocusNode.requestFocus();
                  },
                  controller: model.majorTextController,
                  decoration: InputDecoration(
                    hintText: "Ex: Bachelor of Software Engineering",
                    errorText: "YOUR CONCENTRATIONS",
                    errorStyle: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                    ),
                    counterText: "${model.major?.length ?? 0}/$_maxNameLength",
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
                  maxLength: _maxNameLength,
                  maxLengthEnforced: true,
                  onChanged: (text) =>
                      model.major = model.majorTextController.text,
                ).addMarginTop(),
              ],
            ).addPaddingHorizontal(2).addPaddingVertical().wrapSafeArea(),
          );
        },
      ),
    );
  }
}

enum StoryType {
  school,
  company,
}
