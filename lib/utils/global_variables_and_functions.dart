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

void showContextMenu(BuildContext context, Offset position){
  // Inflate the menu and add items to delete, select, etc.
  final appLocalizations = AppLocalizations.of(context)!;
  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      position.dx,
      position.dy,
    ),
    items: [
      PopupMenuItem(
        value: 1,
        child: Text(appLocalizations.deleteExercise), // "Delete"
      ),
      PopupMenuItem(
        value: 2,
        child: Text(appLocalizations.selectExercise), // "Select"
      ),
    ]
  ).then((value) {
    switch (value) {
      case 1:
        // TODO delete
        break;
      case 2:
        // TODO Select exercises => Send button => Send them
    }
  });
}
