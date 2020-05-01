import 'dart:io';

import 'package:easy_cv/utils/extensions.dart';
import 'package:flutter/material.dart';

BoxDecoration getTopDividerDecoration(BuildContext context) {
  return BoxDecoration(
    border: Border(
      top: BorderSide(
        color: context.theme.primaryColor.withOpacity(0.1),
      ),
    ),
  );
}

bool isMobile() {
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      return true;
    }
  } catch (err) {}
  return false;
}
