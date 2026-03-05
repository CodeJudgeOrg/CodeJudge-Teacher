import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/ui_elements/my_edit_text.dart';
import 'package:code_judge_teacher/utils/code_judge_teacher_db.dart';
import 'package:code_judge_teacher/utils/exercise_datamodell.dart';
import 'package:code_judge_teacher/utils/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Displayed if the user adds a new exercise
class AddOrEditExercisePage extends StatefulWidget{
  final int id;
  final bool isEditingAnExercise;

  const AddOrEditExercisePage({
    super.key,
    required this.id,
    required this.isEditingAnExercise,
  });

  @override
  State<AddOrEditExercisePage> createState() => _AddOrEditExercisePageState();
}

class _AddOrEditExercisePageState extends State<AddOrEditExercisePage> {
  int currentValue = 1;
  // Store the entered data and update the provider depending on it
  late ExerciseDatamodell exercise;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Apply some values to exercise, but just once
    exercise = ExerciseDatamodell(
      id: widget.id,
      name: "",
      description: "",
      task: "",
      solution: "",
      difficultyLevel: 0
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final difficultyLevelFocusNode = FocusNode();
    final db = CodeJudgeTeacherDB();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditingAnExercise
            ? appLocalizations.editExercise // "Edit an exercise"
            : appLocalizations.addExercise, // "Add a new exercise"
        ),
        backgroundColor: theme.colorScheme.primaryContainer,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            // Add the exercise to the list
            context.read<ExerciseProvider>().insertExercise(exercise);
            // TODO Update if editing
            // Close
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          spacing: 8,
          children: [
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: MyEditText(
                    hint: appLocalizations.hintEnterName, // "Name:"
                    onInputDone: (value) {
                      // Store the name
                      db.updateExerciseName(value.trim(), widget.id);
                      exercise.name = value.trim();
                    },
                  ),
                ),
                SizedBox(
                  width: 375,
                  child: ListTile(
                    title: Text(appLocalizations.selectDifficultyLevel), // "Level of difficulty:"
                    trailing: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        focusNode: difficultyLevelFocusNode,
                        value: currentValue,
                        items: [
                          DropdownMenuItem(value: 1, child: Text(appLocalizations.simpleLevel)), // "Beginner"
                          DropdownMenuItem(value: 2, child: Text(appLocalizations.mediumLevel)), // "Intermediate"
                          DropdownMenuItem(value: 3, child: Text(appLocalizations.difficultLevel)), // "Professional"
                        ],
                        onChanged: (value) {
                          // Save the new value
                          exercise.difficultyLevel = value!;
                          db.updateExerciseDifficulty(value, widget.id);
                          // Higlight selected item
                          setState(() {
                            currentValue = value;
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                    ),
                  ),
                ),
              ],
            ),
            MyEditText(
              hint: appLocalizations.hintEnterDescription, // "Description:"
              onInputDone: (value) {
                // Save the changes
                exercise.description = value.trim();
                db.updateExerciseDescription(value, widget.id);
              },
            ),
            MyEditText(
              hint: appLocalizations.hintEnterTask, // "Task:"
              onInputDone: (value) {
                exercise.task = value.trim();
                db.updateExerciseTask(value, widget.id);
              },
            ),
            MyEditText(
              hint: appLocalizations.hintEnterSolution, // "Solution:"
              onInputDone: (value) {
                exercise.solution = value.trim();
                db.updateExerciseSolution(value, widget.id);
              },
            ),
            MyEditText(
              hint: appLocalizations.hintEnterHint, // "Hint:"
              onInputDone: (value) {
                exercise.hint = value.trim();
                db.updateExerciseHint(value, widget.id);
              },
            ),
          ],
        )
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}

// TODO Make this page responsive!
