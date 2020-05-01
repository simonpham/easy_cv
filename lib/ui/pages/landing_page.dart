import 'package:easy_cv/assets.dart';
import 'package:easy_cv/ui/widgets/tappable.dart';
import 'package:easy_cv/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.primaryColor,
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          builder: (context, SizingInformation sizeInfo) {
            if (sizeInfo.isMobile) {
              return Wrap(
                children: <Widget>[
                  _buildFirstSection(context).addMarginLeft(2),
                  _buildSecondSection(context).addMarginTop(),
                ],
              ).addPaddingHorizontal();
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildFirstSection(context).expand(),
                _buildSecondSection(context).expand(),
              ],
            ).wrapWithContainer(maxWidth: 1024);
          },
        ),
      ).center(),
    );
  }

  Widget _buildFirstSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Developer Student Clubs'",
          style: context.textTheme.headline5.copyWith(
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          "Easy CV",
          style: context.textTheme.headline2.copyWith(
            color: Colors.white.withOpacity(0.87),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Create your own perfect CV effortlessly",
          style: context.textTheme.subtitle1.copyWith(
            color: Colors.white.withOpacity(0.4),
            fontWeight: FontWeight.w300,
          ),
        ).addMarginTop(1),
        Container(
          width: 200.0,
          child: Tappable(
            onTap: () {},
            child: RaisedButton(
              onPressed: () {
                "https://easycv.page.link/download".launch();
              },
              child: Text(
                "DOWNLOAD APK",
                style: context.textTheme.subtitle2.copyWith(
                  color: context.theme.primaryColor.withOpacity(0.87),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ).addMarginTop(),
          ),
        ),
      ],
    );
  }

  Widget _buildSecondSection(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          image: Images.desktop,
        ),
        Row(
          children: <Widget>[
            Text(
              "Powered by Flutter",
              style: context.textTheme.caption.copyWith(color: Colors.white38),
              textAlign: TextAlign.center,
            ).expand(),
          ],
        ),
      ],
    );
  }
}
