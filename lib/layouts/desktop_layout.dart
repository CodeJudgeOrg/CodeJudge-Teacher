import 'package:code_judge_library/code_judge_list_items.dart';
import 'package:code_judge_library/code_judge_navigation_bar.dart';
import 'package:code_judge_library/exercise_datamodel.dart';
import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/pages/add_or_edit_exercise_page.dart';
import 'package:code_judge_teacher/pages/settings_page.dart';
import 'package:code_judge_teacher/pages/view_submission_page.dart';
import 'package:code_judge_teacher/utils/code_judge_teacher_db.dart';
import 'package:code_judge_teacher/utils/global_variables_and_functions.dart';
import 'package:code_judge_teacher/utils/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopLayout extends StatefulWidget{

  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<DesktopLayout> {
  Widget getSelectedPage() {
    switch (selectedIndexInNavigationBar) {
      case 0:
        return DesktopSubmissionPage();
      case 1:
        return DesktopExercisePage();
      default:
        return Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CodeJudgeNavigationBar(
      body: getSelectedPage(),
      screenType: CodeJudgeScreenType.desktop,
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

class DesktopExercisePage extends StatelessWidget{
  const DesktopExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    // Get and store all exercises
    final exercises = context.watch<ExerciseProvider>().exercises;

    return Scaffold(
      // Display a list of exercises
      body: GridView.count(
        crossAxisCount: 5,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: List.generate(
          exercises.length,
          (index) {
            final exercise = exercises[index];
            return CodeJudgeDesktopAndTabletItem(
              title: exercise.name,
              note: appLocalizations.noteDifficultyLevel + exercise.difficultyLevel.toString(),
              onTap: (){
                // Open editor
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddOrEditExercisePage(id: exercise.id, isEditingAnExercise: true, position: index)));
              },
              onRightClick: (details) {
                // Open the context menu
                final position = details.globalPosition;
                showContextMenu(context, position, exercise.id);
              },
              onMenuClick: (position) {
                // Open the context menu near the button
                showContextMenu(context, position, exercise.id);
              },
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_rounded),
        label: Text(appLocalizations.newExercise), // New
        onPressed: () async {
          // Insert a new exercise to the db
          int? id = await CodeJudgeTeacherDB().insertNewExercise();
          if (id != null) {
            // Open a page to add a new exercise
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddOrEditExercisePage(isEditingAnExercise: false, id: id)));
          }
        },
      ),
    );
  }
}

class DesktopSubmissionPage extends StatelessWidget{
  DesktopSubmissionPage({super.key});

  final List<ExerciseDatamodel> items = [
    ExerciseDatamodel(id: 1, name: "Abgabe1", description: "Test1", task: "task", solution: "solution", difficultyLevel: 1),
    ExerciseDatamodel(id: 2, name: "Test2", description: "Test2", task: "task", solution: "solution", difficultyLevel: 2),
    ExerciseDatamodel(id: 3, name: "Test2", description: "Test2", task: "task", solution: "solution", difficultyLevel: 2),
    ExerciseDatamodel(id: 4, name: "Test2", description: "Test2", task: "task", solution: "solution", difficultyLevel: 2),
    ExerciseDatamodel(id: 5, name: "Test3", description: "Test3", task: "task", solution: "solution", difficultyLevel: 3),
  ];

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      // Display a list of exercises
      body: GridView.count(
        crossAxisCount: 5,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: List.generate(
          items.length,
          (index) {
            return CodeJudgeDesktopAndTabletItem(
              title: items[index].name,
              note: appLocalizations.noteDifficultyLevel + items[index].difficultyLevel.toString(),
              onTap: (){
                // Display the submission
                Navigator.push(context, MaterialPageRoute(builder: (builder) => ViewSubmissionPage(
                  task: "Test",
                  submission: "Test",
                  studentName: "FR"
                ))); // TODO: Provide the correct values
              }
            );
          }
        ),
      ),
    );
  }
}
