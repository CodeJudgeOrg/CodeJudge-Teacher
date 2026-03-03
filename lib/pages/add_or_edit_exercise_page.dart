import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/ui_elements/my_edit_text.dart';
import 'package:code_judge_teacher/utils/code_judge_teacher_db.dart';
import 'package:flutter/material.dart';

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
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController taskController;
  late TextEditingController solutionController;
  late TextEditingController hintController;
  int currentValue = 1;

  @override
  void initState() {
    super.initState();
    // Set the controllers
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    taskController = TextEditingController();
    solutionController = TextEditingController();
    hintController = TextEditingController();
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
      ),
      body: Expanded(
        child: SingleChildScrollView(
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
                        // Edit the name in the db
                        db.updateExerciseName(value, widget.id);
                        // TODO Add it to the list using a provider
                      },
                    ),
                  ),
                  SizedBox(
                    width: 375,
                    child: ListTile(
                      title: Text(appLocalizations.selectDifficultyLevel), // "Level of difficulty:"
                      trailing: Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            focusNode: difficultyLevelFocusNode,
                            value: currentValue,
                            items: [
                              DropdownMenuItem(value: 1, child: Text(appLocalizations.simpleLevel)), // "Beginner"
                              DropdownMenuItem(value: 2, child: Text(appLocalizations.mediumLevel)), // "Intermediate"
                              DropdownMenuItem(value: 3, child: Text(appLocalizations.difficultLevel)), // "Professional"
                            ],
                            onChanged: (value) {
                              // Higlight selected item
                              setState(() {
                                currentValue = value!;
                              });
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyEditText(
                hint: appLocalizations.hintEnterDescription, // "Description:"
              ),
              MyEditText(
                hint: appLocalizations.hintEnterTask, // "Task:"
              ),
              MyEditText(
                hint: appLocalizations.hintEnterSolution, // "Solution:"
              ),
              MyEditText(
                hint: appLocalizations.hintEnterHint, // "Hint:"
              ),
            ],
          )
        )
      ),
    );
  }
}

// TODO Make this page responsive!
