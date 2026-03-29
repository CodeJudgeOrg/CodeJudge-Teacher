import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/utils/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectionAppBar extends StatelessWidget implements PreferredSizeWidget{

  const SelectionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool showSelectionBar = context.watch<ExerciseProvider>().showSelectionBar;

    // Show and hide the AppBar depending on showAppBar
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      child: showSelectionBar
        ? AppBar(
            title: Text(AppLocalizations.of(context)!.selection), // "Selection"
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton( // Unselect all exercises
              onPressed: () {
                context.read<ExerciseProvider>().unselectAllExercises();
              },
              icon: Icon(Icons.deselect_outlined),
            ),
            actions: [
              // TODO: Button to delete all selected exercises
              IconButton(
                onPressed: () {
                  // TODO Upload all selected exercises to the server
                },
                icon: Icon(Icons.upload_file_outlined),
              ),
            ],
          )
        : SizedBox.shrink()
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}