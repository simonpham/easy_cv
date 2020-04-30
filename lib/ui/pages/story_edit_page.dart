import 'package:easy_cv/view_models/story_edit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

final storyEditViewModel = StoryEditViewModel();

class StoryEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: storyEditViewModel,
      child: ScopedModelDescendant<StoryEditViewModel>(
        builder: (BuildContext context, _, StoryEditViewModel model) {
          return Container();
        },
      ),
    );
  }
}
