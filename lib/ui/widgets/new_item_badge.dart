import 'package:easy_cv/ui/widgets/tappable.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:flutter/material.dart';

class NewItemBadge extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const NewItemBadge({
    Key key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          elevation: 12.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.indigo,
              ),
              Text(
                title ?? "",
                style: context.textTheme.subtitle2.copyWith(
                  color: context.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ).addMarginTop(1),
            ],
          ),
        ),
      ),
    );
  }
}
