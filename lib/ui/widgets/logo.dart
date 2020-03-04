import 'package:flutter/material.dart';
import 'package:easy_cv/utils/extensions.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text(
        "Easy CV",
        style: context.textTheme.headline2.copyWith(
          color: context.theme.primaryColor,
        ),
      ).wrapHero("logo"),
    );
  }
}
