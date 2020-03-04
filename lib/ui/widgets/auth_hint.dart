import 'package:flutter/material.dart';
import 'package:easy_cv/utils/extensions.dart';

class AuthHint extends StatelessWidget {
  final String routeName;
  final String preLabel;
  final String label;

  const AuthHint({
    Key key,
    this.routeName,
    this.preLabel,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(preLabel),
              InkWell(
                onTap: () => context.navigator.pushReplacementNamed(routeName),
                child: Text(
                  label,
                  style: TextStyle(color: context.theme.primaryColor),
                ),
              ),
            ],
          )
        ],
      ),
    ).wrapHero("auth_hint");
  }
}
