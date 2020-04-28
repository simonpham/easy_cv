import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/view_models/begin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BeginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel<BeginViewModel>(
        model: beginViewModel,
        child: ScopedModelDescendant(
          builder: (BuildContext context, _, BeginViewModel model) {
            return PageView(
              controller: model.mainPageController,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Welcome(model),
                PageName(model),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Welcome extends StatelessWidget {
  final BeginViewModel model;

  const Welcome(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Column(
        children: <Widget>[
          Text("Hello"),
          Container().expand(),
          RaisedButton(
            child: Text(
              "BEGIN",
              style: context.textTheme.subtitle1,
            ),
            onPressed: () => model.mainPageController.goTo(1),
          )
        ],
      ).addPaddingHorizontal().addPaddingVertical(3),
    );
  }
}

class PageName extends StatelessWidget {
  final BeginViewModel model;

  const PageName(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: Column(
        children: <Widget>[
          Text("Hello"),
        ],
      ),
    );
  }
}
