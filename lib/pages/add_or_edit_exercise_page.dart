import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/ui_elements/my_edit_text.dart';
import 'package:code_judge_teacher/utils/code_judge_teacher_db.dart';
import 'package:flutter/material.dart';

class AddOrEditExercisePage extends StatelessWidget{
  final bool isEditingAnExercise;
  final int id;

  const AddOrEditExercisePage({
    super.key,
    required this.isEditingAnExercise,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final CodeJudgeTeacherDB db = CodeJudgeTeacherDB();

    // Pick the correct layout
    if (isEditingAnExercise) {
      return EditExerciseLayout();
    } else {
      return AddExerciseLayout(db: db, id: id);
    }
  }
}

// Displayed if the user adds a new exercise
class AddExerciseLayout extends StatefulWidget{
  final CodeJudgeTeacherDB db;
  final int id;

  const AddExerciseLayout({
    super.key,
    required this.db,
    required this.id,
  });

  @override
  State<AddExerciseLayout> createState() => _AddExerciseLayoutState();
}

class _AddExerciseLayoutState extends State<AddExerciseLayout> {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.addExercise), // "Add a new exercise"
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
                        widget.db.updateExerciseName(value, widget.id);
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

// Displayed if the user edits an exercise
class EditExerciseLayout extends StatelessWidget{
  const EditExerciseLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.editExercise), // "Edit an exercise"
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: Placeholder(),
    );
  }
}
