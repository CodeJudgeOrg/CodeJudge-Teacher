library;

import 'package:code_judge_library/code_judge_navigation_bar.dart';
import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/pages/add_or_edit_exercise_page.dart';
import 'package:code_judge_teacher/utils/code_judge_teacher_db.dart';
import 'package:code_judge_teacher/utils/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

int selectedIndexInNavigationBar = 0;

List<MyNavigationBarItemData> getNavigationBarItems(BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;
  return [
    MyNavigationBarItemData(icon: Icons.assignment_returned_outlined, label: appLocalizations.submissions), // Submission
    MyNavigationBarItemData(icon: Icons.task_alt_outlined, label: appLocalizations.exercises), // Exercises
    MyNavigationBarItemData(icon: Icons.settings_outlined, label: appLocalizations.settings), // Settings
  ];
}

void showContextMenu(BuildContext context, Offset position, int id, int itemPosition){
  // Inflate the menu and add items to delete, select, etc.
  final appLocalizations = AppLocalizations.of(context)!;
  final db = CodeJudgeTeacherDB();

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
        child: Text(appLocalizations.selectExercise), // "Select"
      ),
      PopupMenuItem(
        value: 2,
        child: Text(appLocalizations.menuEditExercise), // "Edit"
      ),
      PopupMenuItem(
        value: 3,
        child: Text(appLocalizations.deleteExercise), // "Delete"
      ),
    ]
  ).then((value) {
    switch (value) {
      case 1:
        // Select exercises
        context.read<ExerciseProvider>().toggleSelectionOfExercise(itemPosition, true);
        break;
      case 2:
        // Open the editor
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddOrEditExercisePage(id: id, isEditingAnExercise: true, position: itemPosition)));
        break;
      case 3:
        // Delete an exercise
        db.deleteExercise(id);
        context.read<ExerciseProvider>().deleteExercise(id);
        break;
    }
  });
}
