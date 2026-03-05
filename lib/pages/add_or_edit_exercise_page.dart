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
  final int position;
  final bool isEditingAnExercise;

  const AddOrEditExercisePage({
    super.key,
    required this.id,
    required this.isEditingAnExercise,
    this.position = 0,
  });

  @override
  State<AddOrEditExercisePage> createState() => _AddOrEditExercisePageState();
}

class _AddOrEditExercisePageState extends State<AddOrEditExercisePage> {
  int currentValue = 1;
  // Store the entered data and update the provider depending on it
  ExerciseDatamodell? exercise;
  late CodeJudgeTeacherDB db;

  @override
  void initState() {
    super.initState();
    db = CodeJudgeTeacherDB();

    // Apply values to exercise, but just once
    if (widget.isEditingAnExercise) {
      loadExerciseData();
    } else {
      exercise = ExerciseDatamodell(
        id: widget.id,
        name: "",
        description: "",
        task: "",
        solution: "",
        difficultyLevel: 1,
        hint: ""
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final difficultyLevelFocusNode = FocusNode();

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
            // Update the list
            if (widget.isEditingAnExercise && exercise != null) {
              context.read<ExerciseProvider>().editExercise(exercise!, widget.position);
            } else if (exercise != null) {
              context.read<ExerciseProvider>().insertExercise(exercise!);
            }
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
                    text: exercise?.name,
                    onInputDone: (value) {
                      // Store the name
                      db.updateExerciseName(value.trim(), widget.id);
                      if (exercise != null) {
                        exercise!.name = value.trim();
                      }
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
                        value: exercise != null ? exercise!.difficultyLevel: 1,
                        items: [
                          DropdownMenuItem(value: 1, child: Text(appLocalizations.simpleLevel)), // "Beginner"
                          DropdownMenuItem(value: 2, child: Text(appLocalizations.mediumLevel)), // "Intermediate"
                          DropdownMenuItem(value: 3, child: Text(appLocalizations.difficultLevel)), // "Professional"
                        ],
                        onChanged: (value) {
                          // Save the new value
                          if (exercise != null && value != null) {
                            exercise!.difficultyLevel = value;
                            db.updateExerciseDifficulty(value, widget.id);
                          }
                          // Higlight selected item
                          setState(() {});
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
              text: exercise?.description,
              onInputDone: (value) {
                // Save the changes
                if (exercise != null) {
                  exercise!.description = value.trim();
                }
                db.updateExerciseDescription(value, widget.id);
              },
            ),
            MyEditText(
              hint: appLocalizations.hintEnterTask, // "Task:"
              text: exercise?.task,
              onInputDone: (value) {
                // Save the changes
                if (exercise != null) {
                  exercise!.task = value.trim();
                }
                db.updateExerciseTask(value, widget.id);
              },
            ),
            MyEditText(
              hint: appLocalizations.hintEnterSolution, // "Solution:"
              text: exercise?.solution,
              onInputDone: (value) {
                // Save the changes
                if (exercise != null) {
                  exercise!.solution = value.trim();
                }
                db.updateExerciseSolution(value, widget.id);
              },
            ),
            MyEditText(
              hint: appLocalizations.hintEnterHint, // "Hint:"
              text: exercise?.hint,
              onInputDone: (value) {
                // Save the changes
                if (exercise != null) {
                  exercise!.hint = value.trim();
                }
                db.updateExerciseHint(value, widget.id);
              },
            ),
          ],
        )
      ),
    );
  }

  // Receive the data from teh db and display it
  Future<void> loadExerciseData() async {
    final result = await db.getDataOfExercise(widget.id);
    if (result != null) {
      exercise = result;
      setState(() {});
    } else {
      exercise = ExerciseDatamodell(
        id: widget.id,
        name: "",
        description: "",
        task: "",
        solution: "",
        difficultyLevel: 1,
        hint: ""
      );
    }
  }
}

// TODO Make this page responsive!
