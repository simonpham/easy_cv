import 'package:easy_cv/singleton_instances.dart';
import 'package:easy_cv/ui/pages/sign_in_page.dart';
import 'package:easy_cv/ui/widgets/tappable.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/view_models/begin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

const _maxNameLength = 32;
const _maxBioLength = 100;
const _navigateButtonsHeight = 100.0;

class BeginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel<BeginViewModel>(
        model: beginViewModel,
        child: ScopedModelDescendant(
          builder: (BuildContext context, _, BeginViewModel model) {
            final _pages = [
              Welcome(model),
              PageName(model),
              PageLocation(model),
              PageEmail(model),
              PageBio(model),
              PageEducation(model),
              PageExperience(model),
              PageUsername(model),
              PagePassword(model),
            ];
            return Stack(
              children: <Widget>[
                Positioned.fill(
                  child: PageView(
                    controller: model.mainPageController,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: _pages,
                    onPageChanged: (page) => model.currentPage = page,
                  ),
                ),
                Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: _buildNavigateButtons(context, model, _pages),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavigateButtons(
      BuildContext context, BeginViewModel model, List<StatelessWidget> pages) {
    final currentPage = model.currentPage;
    final lastPage = pages.length - 1;
    if (currentPage == 0 || currentPage == pages.length - 1) {
      return SizedBox();
    }
    return Column(
      children: <Widget>[
        Tappable(
          onTap: () {
            final previousPage = currentPage - 1;
            if (previousPage >= 0) {
              model.mainPageController.goTo(previousPage);
            }
          },
          child: Icon(
            Icons.keyboard_arrow_up,
            size: 30,
            color: Colors.white,
          ).addPadding(),
        ),
        Tappable(
          onTap: () {
            final nextPage = currentPage + 1;
            if (nextPage == lastPage) {
              // TODO: show dialog - can't go back
            }
            if (nextPage < pages.length) {
              model.mainPageController.goTo(nextPage);
            }
          },
          child: Icon(
            Icons.keyboard_arrow_down,
            size: 30,
            color: Colors.white,
          ).addPadding(),
        ).addMarginTop(1),
      ],
    ).addPaddingHorizontal(3).addPaddingVertical(3).wrapSafeArea();
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                onPressed: () => context.navigator.push(
                  SignInPage().route(context),
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
    return Container(
      color: Colors.deepPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            onChanged: (text) =>
                model.firstName = model.firstNameTextController.text,
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
            onChanged: (text) =>
                model.lastName = model.lastNameTextController.text,
          ).addMarginTop(),
          Container().expand(),
          SizedBox(height: _navigateButtonsHeight),
        ],
      ).addPaddingHorizontal(3).addPaddingVertical(3).wrapSafeArea(),
    );
  }
}

class PageLocation extends StatelessWidget {
  final BeginViewModel model;

  const PageLocation(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Where do you live?",
            style: context.textTheme.headline5.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ).addMarginTop(),
          Container().expand(),
          TextField(
            controller: model.locationTextController,
            decoration: InputDecoration(
              hintText: "I'm living at..",
              errorText: "YOUR CURRENT LOCATION",
              errorStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
              ),
              counterText: "${model.location?.length ?? 0}/$_maxNameLength",
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
                model.location = model.locationTextController.text,
          ).addMarginTop(),
          Container().expand(),
          SizedBox(height: _navigateButtonsHeight),
        ],
      ).addPaddingHorizontal(3).addPaddingVertical(3).wrapSafeArea(),
    );
  }
}

class PageEmail extends StatelessWidget {
  final BeginViewModel model;

  const PageEmail(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "What's your email address?",
            style: context.textTheme.headline5.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ).addMarginTop(),
          Container().expand(),
          TextField(
            controller: model.emailTextController,
            decoration: InputDecoration(
              hintText: "My email address is..",
              errorText: "YOUR EMAIL ADDRESS",
              errorStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
              ),
              counterText: "${model.email?.length ?? 0}/$_maxNameLength",
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
            onChanged: (text) => model.email = model.emailTextController.text,
          ).addMarginTop(),
          Container().expand(),
          SizedBox(height: _navigateButtonsHeight),
        ],
      ).addPaddingHorizontal(3).addPaddingVertical(3).wrapSafeArea(),
    );
  }
}

class PageBio extends StatelessWidget {
  final BeginViewModel model;

  const PageBio(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Add a short bio to tell people more about yourself",
            style: context.textTheme.headline5.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ).addMarginTop(),
          Container().expand(),
          TextField(
            controller: model.bioTextController,
            decoration: InputDecoration(
              hintText: "I eat code for breakfast..",
              errorText: "YOUR SHORT BIO",
              errorStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
              ),
              counterText: "${model.bio?.length ?? 0}/$_maxBioLength",
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
            maxLength: _maxBioLength,
            maxLengthEnforced: true,
            onChanged: (text) => model.bio = model.bioTextController.text,
          ).addMarginTop(),
          Container().expand(),
          SizedBox(height: _navigateButtonsHeight),
        ],
      ).addPaddingHorizontal(3).addPaddingVertical(3).wrapSafeArea(),
    );
  }
}

class PageEducation extends StatelessWidget {
  final BeginViewModel model;

  const PageEducation(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Add a college",
            style: context.textTheme.headline5.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ).addMarginTop(),
          Container().expand(),
          TextField(
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
            onChanged: (text) => model.school = model.schoolTextController.text,
          ).addMarginTop(),
          TextField(
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
            onChanged: (text) => model.major = model.majorTextController.text,
          ).addMarginTop(),
          Container().expand(),
          SizedBox(height: _navigateButtonsHeight),
        ],
      ).addPaddingHorizontal(3).addPaddingVertical(3).wrapSafeArea(),
    );
  }
}

class PageExperience extends StatelessWidget {
  final BeginViewModel model;

  const PageExperience(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Add a workplace",
            style: context.textTheme.headline5.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ).addMarginTop(),
          Container().expand(),
          TextField(
            controller: model.companyTextController,
            decoration: InputDecoration(
              hintText: "Where have you worked?",
              errorText: "YOUR COMPANY",
              errorStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
              ),
              counterText: "${model.company?.length ?? 0}/$_maxNameLength",
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
                model.company = model.companyTextController.text,
          ).addMarginTop(),
          TextField(
            controller: model.positionTextController,
            decoration: InputDecoration(
              hintText: "What is your job title?",
              errorText: "YOUR POSITION",
              errorStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
              ),
              counterText: "${model.position?.length ?? 0}/$_maxNameLength",
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
                model.position = model.positionTextController.text,
          ).addMarginTop(),
          TextField(
            controller: model.companyLocationTextController,
            decoration: InputDecoration(
              hintText: "My company is located in..",
              errorText: "YOUR COMPANY'S LOCATION",
              errorStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
              ),
              counterText:
                  "${model.companyLocation?.length ?? 0}/$_maxNameLength",
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
            onChanged: (text) => model.companyLocation =
                model.companyLocationTextController.text,
          ).addMarginTop(),
          Container().expand(),
          SizedBox(height: _navigateButtonsHeight),
        ],
      ).addPaddingHorizontal(3).addPaddingVertical(3).wrapSafeArea(),
    );
  }
}

class PageUsername extends StatelessWidget {
  final BeginViewModel model;

  const PageUsername(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Choose a username. This will be include in the URL of your profile.",
            style: context.textTheme.headline5.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ).addMarginTop(),
          Container().expand(),
          TextField(
            controller: model.usernameTextController,
            decoration: InputDecoration(
              hintText: "My username is..",
              errorText: "YOUR USERNAME",
              errorStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
              ),
              counterText: "${model.username?.length ?? 0}/$_maxNameLength",
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
                model.username = model.usernameTextController.text,
          ).addMarginTop(),
          Container().expand(),
          SizedBox(height: _navigateButtonsHeight),
        ],
      ).addPaddingHorizontal(3).addPaddingVertical(3).wrapSafeArea(),
    );
  }
}

class PagePassword extends StatelessWidget {
  final BeginViewModel model;

  const PagePassword(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Final step! Create a password.",
            style: context.textTheme.headline5.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ).addMarginTop(),
          Container().expand(),
          TextField(
            controller: model.passwordTextController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "••••••••",
              errorText: "YOUR PASSWORD",
              errorStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
              ),
              counterText: "${model.password?.length ?? 0}/$_maxNameLength",
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
                model.password = model.passwordTextController.text,
          ).addMarginTop(),
          Container().expand(),
          Row(
            children: <Widget>[
              RaisedButton(
                elevation: 16.0,
                child: Text(
                  "CREATE MY RESUME!",
                  style: context.textTheme.subtitle2.copyWith(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  // TODO: show dialog
                },
              ).expand()
            ],
          ),
          SizedBox(height: 32.0),
        ],
      ).addPaddingHorizontal(3).addPaddingVertical(3).wrapSafeArea(),
    );
  }
}
