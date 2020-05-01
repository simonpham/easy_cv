import 'dart:io';

import 'package:easy_cv/utils/extensions.dart';
import 'package:easy_cv/utils/utils.dart';
import 'package:flutter/material.dart';

class SectionItem extends StatelessWidget {
  final String title;
  final String label;
  final String degree;
  final String company;
  final String location;
  final String summary;
  final int startDate;
  final int endDate;
  final bool showDivider;
  final bool isCurrent;
  final bool isNotLoggedIn;

  const SectionItem({
    Key key,
    this.title,
    this.label,
    this.degree,
    this.company,
    this.location,
    this.summary,
    this.startDate,
    this.endDate,
    this.showDivider,
    this.isCurrent,
    this.isNotLoggedIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: showDivider.ifTrue(
        getTopDividerDecoration(context),
        null,
      ),
      child: Wrap(
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildTitle(context).expand(),
              _buildLabel(context),
            ],
          ),
          _buildDetail(context),
          _buildSummary(context),
        ],
      ).addPaddingVertical(3),
    );
  }

  Widget _buildTitle(BuildContext context) {
    if (title?.isEmpty ?? true) {
      return SizedBox();
    }
    return Text(
      title ?? "",
      style: context.textTheme.headline5.copyWith(
        color: context.theme.primaryColor.withOpacity(0.87),
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    if (label?.isEmpty ?? true) {
      return SizedBox();
    }
    return Container(
      decoration: BoxDecoration(
        color: context.theme.accentColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Text(
        label ?? "",
        style: context.textTheme.subtitle2.copyWith(
          color: context.theme.primaryColor.withOpacity(0.87),
          fontWeight: FontWeight.w500,
        ),
      ).addPaddingVertical().addPaddingHorizontal(),
    );
  }

  List<Widget> _buildCompany(BuildContext context) {
    if (company?.isEmpty ?? true) {
      return [];
    }
    return [
      Icon(
        Icons.business,
        color: context.theme.unselectedWidgetColor.withOpacity(0.45),
        size: 20,
      ),
      Text(
        company ?? "",
        style: context.textTheme.subtitle2.copyWith(
          color: context.theme.unselectedWidgetColor.withOpacity(0.45),
          fontWeight: FontWeight.w500,
        ),
      ).addMarginLeft(0.5)
    ];
  }

  List<Widget> _buildLocation(BuildContext context) {
    if (location?.isEmpty ?? true) {
      return [];
    }
    int factor = 2;
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        factor = 1;
      }
    } catch (_) {}
    return [
      Icon(
        Icons.place,
        color: context.theme.unselectedWidgetColor.withOpacity(0.45),
        size: 20,
      ).addMarginLeft(factor),
      Text(
        location ?? "",
        style: context.textTheme.subtitle2.copyWith(
          color: context.theme.unselectedWidgetColor.withOpacity(0.45),
          fontWeight: FontWeight.w500,
        ),
      ).addMarginLeft(0.25 * factor)
    ];
  }

  Widget _buildSpacer() {
    return Container().expand();
  }

  List<Widget> _buildDates(BuildContext context) {
    if (startDate == null) {
      return [];
    }

    String date = "$startDate".toDate();
    if (isCurrent == true) {
      date = "$date - Now";
    } else {
      if (endDate != null) {
        date = "$date - ${endDate.toString().toDate()}";
      }
    }
    return [
      Icon(
        Icons.calendar_today,
        color: context.theme.unselectedWidgetColor.withOpacity(0.45),
        size: 20,
      ),
      Text(
        date ?? "",
        style: context.textTheme.subtitle2.copyWith(
          color: context.theme.unselectedWidgetColor.withOpacity(0.45),
          fontWeight: FontWeight.w500,
        ),
      ).addMarginLeft(0.5)
    ];
  }

  Widget _buildSummary(BuildContext context) {
    if (summary?.isEmpty ?? true) {
      return SizedBox();
    }
    return Row(
      children: <Widget>[
        Text(
          summary ?? "",
          style: context.textTheme.subtitle2.copyWith(
            color: context.theme.primaryColor.withOpacity(0.87),
            fontWeight: FontWeight.w400,
          ),
        ).expand(),
      ],
    ).addMarginTop();
  }

  _buildDetail(BuildContext context) {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        return Column(
          children: <Widget>[
            Row(
                children: <Widget>[]
                  ..addAll(_buildCompany(context))
                  ..addAll(_buildLocation(context))),
            Row(
              children: <Widget>[]..addAll(
                  _buildDates(context),
                ),
            ).addMarginTop(),
          ],
        ).addMarginTop();
      }
    } catch (err) {}
    return Row(
      children: <Widget>[]
        ..addAll(_buildCompany(context))
        ..addAll(_buildLocation(context))
        ..add(_buildSpacer())
        ..addAll(_buildDates(context)),
    ).addMarginTop();
  }
}
