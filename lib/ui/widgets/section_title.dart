import 'package:easy_cv/utils/extensions.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "",
      style: context.textTheme.headline4.copyWith(
        color: context.theme.primaryColor.withOpacity(0.87),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
