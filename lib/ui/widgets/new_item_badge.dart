import 'package:flutter/material.dart';

class NewItemBadge extends StatelessWidget {
  final IconData icon;
  final String title;

  const NewItemBadge({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.white,
      height: 100.0,
      width: 100.0,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
            ),
            Text(
              title ?? "",
            ),
          ],
        ),
      ),
    );
  }
}
