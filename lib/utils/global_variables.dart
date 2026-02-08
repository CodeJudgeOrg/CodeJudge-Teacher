library;

import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/ui_elements/my_navigation_bar.dart';
import 'package:flutter/material.dart';

int selectedIndexInNavigationBar = 0;

List<MyNavigationBarItemData> getNavigationBarItems(BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;
  return [
    MyNavigationBarItemData(icon: Icons.code, label: appLocalizations.submissions), // Submission
    MyNavigationBarItemData(icon: Icons.code, label: appLocalizations.exercises), // Exercises
    MyNavigationBarItemData(icon: Icons.settings, label: appLocalizations.settings), // Settings
  ];
}
