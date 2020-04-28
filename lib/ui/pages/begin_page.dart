import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/ui/pages/sign_in_page.dart';
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
          Text(
            "Hi there,\nI'm Resumey",
            style: context.textTheme.headline4.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "I will help you\nbuilding your own perfect CV\nwith just a few questions",
            style: context.textTheme.headline6.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ).addMarginTop(),
          Container().expand(),
          Row(
            children: <Widget>[
              RaisedButton(
                elevation: 16.0,
                child: Text(
                  "HI, RESUMEY!",
                  style: context.textTheme.subtitle2.copyWith(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () => model.mainPageController.goTo(1),
              ).expand()
            ],
          ),
          Row(
            children: <Widget>[
              FlatButton(
                child: Text(
                  "I ALREADY HAVE AN ACCOUNT",
                  style: context.textTheme.subtitle2.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () => context.navigator.pushReplacementNamed(
                  SignInPage.routeName,
                ),
              ).expand()
            ],
          ).addMarginTop(4),
        ],
      ).addPaddingHorizontal(6).addPaddingVertical(6).wrapSafeArea(),
    );
  }
}

class PageName extends StatelessWidget {
  final BeginViewModel model;

  const PageName(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _maxNameLength = 32;
    return Container(
      color: Colors.deepPurple,
      child: Column(
        children: <Widget>[
          Text(
            "Nice to meet you! What do your friends call you?",
            style: context.textTheme.headline5.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ).addMarginTop(),
          Container().expand(),
          TextField(
            controller: model.firstNameTextController,
            decoration: InputDecoration(
              hintText: "They call me..",
              errorText: "YOUR FIRST NAME",
              errorStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
              ),
              counterText: "${model.firstName?.length ?? 0}/$_maxNameLength",
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
            onChanged: (text) => model.firstName = model.firstNameTextController.text,
          ).addMarginTop(),
          TextField(
            controller: model.lastNameTextController,
            decoration: InputDecoration(
              hintText: "And last but not least..",
              errorText: "YOUR LAST NAME",
              errorStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
              ),
              counterText: "${model.lastName?.length ?? 0}/$_maxNameLength",
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
            onChanged: (text) => model.lastName = model.lastNameTextController.text,
          ).addMarginTop(),
          Container().expand(),
        ],
      ).addPaddingHorizontal(3).addPaddingVertical(3).wrapSafeArea(),
    );
  }
}
