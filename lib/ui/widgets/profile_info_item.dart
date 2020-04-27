import 'package:easy_cv/utils/extensions.dart';
import 'package:flutter/material.dart';

class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool showDivider;

  const ProfileInfoItem({
    Key key,
    this.icon,
    this.title,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon == null || title == null) {
      return SizedBox();
    }
    return Container(
      decoration: showDivider.ifTrue(
        BoxDecoration(
          border: Border(
            top: BorderSide(
              color: context.theme.unselectedWidgetColor.withOpacity(0.1),
            ),
          ),
        ),
        null,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: context.theme.unselectedWidgetColor,
            size: 20,
          ),
          Text(
            "$title",
            style: context.textTheme.subtitle1.copyWith(
              color: context.theme.primaryColor.withOpacity(0.87),
              fontWeight: FontWeight.w500,
            ),
          ).addMarginLeft(),
        ],
      ).addPaddingVertical(2).addPaddingHorizontal(2),
    );
  }
}
