import 'package:code_judge_library/code_judge_button_menu.dart';
import 'package:code_judge_library/code_judge_list_items.dart';
import 'package:code_judge_library/code_judge_navigation_bar.dart';
import 'package:code_judge_library/datamodels.dart';
import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/pages/add_or_edit_exercise_page.dart';
import 'package:code_judge_teacher/pages/settings_page.dart';
import 'package:code_judge_teacher/pages/view_submission_page.dart';
import 'package:code_judge_teacher/utils/api_connector.dart';
import 'package:code_judge_teacher/utils/code_judge_teacher_db.dart';
import 'package:code_judge_teacher/utils/global_variables_and_functions.dart';
import 'package:code_judge_teacher/utils/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileLayout extends StatefulWidget{

  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  Widget getSelectedPage() {
    switch (selectedIndexInNavigationBar) {
      case 0:
        return MobileSubmissionPage();
      case 1:
        return MobileExercisePage();
      default:
        return Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CodeJudgeNavigationBar(
      body: getSelectedPage(),
      screenType: CodeJudgeScreenType.mobile,
      selectedIndex: selectedIndexInNavigationBar,
      onItemSelected: (index) {
        if (index != 2) {
          setState(() {
            selectedIndexInNavigationBar = index;
          });
        } else {
          // Open settings
          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
        }
      },
      items: getNavigationBarItems(context),
    );
  }
}

class MobileExercisePage extends StatelessWidget{
  const MobileExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    // Get and store all exercises
    final exercises = context.watch<ExerciseProvider>().exercises;

    return Scaffold(
      // Display a list of exercises
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: exercises.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return CodeJudgeMobileItem(
            title: exercise.name,
            note: appLocalizations.noteDifficultyLevel + exercise.difficultyLevel.toString(),
            isSelected: exercise.isSelected,
            onTap: (){
              // If this exercise is selected, unselect it
              if (exercise.isSelected) {
                context.read<ExerciseProvider>().toggleSelectionOfExercise(index, false);
                return;
              }

              // Open editor
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddOrEditExercisePage(id: exercise.id, isEditingAnExercise: true, position: index)));
            },
            onRightClick: (details) {
              // Open the context menu
              final position = details.globalPosition;
              showContextMenu(context, position, exercise.id, index);
            },
            onMenuClick: (position) {
              // Open the context menu near the button
              showContextMenu(context, position, exercise.id, index);
            },
            onLongPress: (details){
              // Select this exercise
              context.read<ExerciseProvider>().toggleSelectionOfExercise(index, true);
              // TODO Send button => Send them
            },
          );
        },
      ),
      floatingActionButton: CodeJudgeButtonMenu(
        show: context.watch<ExerciseProvider>().showSelectionBar,
        icon: Icons.add_rounded,
        label: appLocalizations.newExercise, // "New"
        onDeselectPressed: () => context.read<ExerciseProvider>().unselectAllExercises(), // Unselect all selected exercises
        onUploadPressed: () => ApiConnector().uploadExercises(context), // Upload all selected exercises
        onDeletePressed: () async {
          // Delete the selected exercises
          await CodeJudgeTeacherDB().deleteExercises(context.read<ExerciseProvider>().exercises);
          context.read<ExerciseProvider>().deleteSelectedExercises();
        },
        onButtonPressed: () async {
          // Insert a new exercise to the db
          int? id = await CodeJudgeTeacherDB().insertNewExercise();
          if (id != null) {
            // Open a page to add a new exercise
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddOrEditExercisePage(isEditingAnExercise: false, id: id)));
          }
        }
      ),
    );
  }
}

class MobileSubmissionPage extends StatelessWidget{
  const MobileSubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final List<SubmissionDatamodel> submissions = context.watch<SubmissionProvider>().submissions;

    return Scaffold(
      // Display a list of exercises
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: submissions.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return CodeJudgeMobileItem(
            title: submissions[index].exerciseName,
            note: submissions[index].studentName,
            onTap: (){
              // Display the submission
              Navigator.push(context, MaterialPageRoute(builder: (builder) => ViewSubmissionPage(
                task: submissions[index].task,
                submission: submissions[index].code,
                studentName: submissions[index].studentName
              ))); // TODO: Use all values
            }
          );
        },
        
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.sync_rounded),
        label: Text(appLocalizations.syncButton), // Syncronise
        onPressed: () {
          // Update the list
          ApiConnector().receiveSubmissions(context);
        },
      ),
    );
  }
}
