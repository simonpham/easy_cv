import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_cv/utils/string_utils.dart';

import 'package:url_launcher/url_launcher.dart' as url;

extension StringExtension on String {
  bool validate(Pattern pattern) {
    return RegexUtils.check(this, pattern);
  }

  Future launch() async {
    if (await url.canLaunch(this)) {
      return url.launch(this);
    }
  }
}

extension ExtendedTextEditingController on TextEditingController {
  void selectAll() {
    this.selection = TextSelection(
      baseOffset: 0,
      extentOffset: this.text.length,
    );
  }
}

extension ScrollControllerExtension on ScrollController {
  Future<void> goTo(double offset) {
    return this.animateTo(
      offset,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }
}

extension ExtendedPageController on PageController {
  Future<void> goTo(int page) {
    return this.animateToPage(
      page,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }
}

extension ExtendedContext on BuildContext {
  void hideKeyboard() {
    if (!this.focus.hasPrimaryFocus) {
      this.focus.unfocus();
    }
  }

  MediaQueryData get query {
    return MediaQuery.of(this);
  }

  FocusScopeNode get focus {
    return FocusScope.of(this);
  }

//  AppLocalizations get local {
//    return AppLocalizations.of(this);
//  }

  ThemeData get theme {
    return Theme.of(this);
  }

  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  NavigatorState get navigator {
    return Navigator.of(this);
  }

  bool pop([result]) {
    return Navigator.of(this).pop(result);
  }

  Future showAlertDialog({String title, @required String message}) {
    return showDialog<void>(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          title: (title != null).ifTrue(
            Text(
              title?.toUpperCase() ?? "",
            ),
          ),
          content: Text(
            message ?? "",
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("OKAY"),
              onPressed: () => this.pop(),
            ),
          ],
        );
      },
    );
  }
}

extension ExtendedBool on bool {
  ifTrue(yes, [no]) {
    if (yes is Widget && this == false) {
      return no ?? SizedBox();
    }
    return this ? yes : no;
  }
}

extension ExtendedWidget on Widget {
  Widget roundedBorder(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  Widget wrapWithContainer({
    AlignmentGeometry alignment,
    paddingScale = 2,
    double maxWidth = 500.0,
  }) {
    return Container(
      alignment: alignment ?? Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: 8.0 * paddingScale),
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      child: this,
    );
  }

  Widget addMarginTop([num factor = 2]) {
    return Container(
      margin: EdgeInsets.only(top: 8.0 * factor),
      child: this,
    );
  }

  Widget addMarginLeft([num factor = 1]) {
    return Container(
      margin: EdgeInsets.only(left: 8.0 * factor),
      child: this,
    );
  }

  Widget addMarginRight([num factor = 1]) {
    return Container(
      margin: EdgeInsets.only(right: 8.0 * factor),
      child: this,
    );
  }

  Widget addPaddingVertical([num factor = 1]) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0 * factor),
      child: this,
    );
  }

  Widget addPaddingHorizontal([num factor = 3]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0 * factor),
      child: this,
    );
  }

  Widget center() {
    return Center(
      child: this,
    );
  }

  Widget expand([flex = 1]) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  Widget flexible([flex = 1, fit = FlexFit.loose]) {
    return Flexible(
      flex: flex,
      fit: fit,
      child: this,
    );
  }

  Widget wrapHero(String tag) {
    return Hero(
      tag: tag,
      flightShuttleBuilder: (BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext) {
        return Material(
          child: toHeroContext.widget,
        );
      },
      child: this,
    );
  }
}