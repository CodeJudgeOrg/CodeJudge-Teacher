import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/main.dart';
import 'package:code_judge_teacher/pages/add_or_edit_exercise_page.dart';
import 'package:code_judge_teacher/pages/settings_page.dart';
import 'package:code_judge_teacher/ui_elements/my_list_items.dart';
import 'package:code_judge_teacher/ui_elements/my_navigation_bar.dart';
import 'package:code_judge_teacher/utils/code_judge_teacher_db.dart';
import 'package:code_judge_teacher/utils/exercise_datamodell.dart';
import 'package:code_judge_teacher/utils/global_variables.dart';
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
    return MyNavigationBar(
      body: getSelectedPage(),
      screenType: ScreenType.mobile,
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
          return MyMobileItem(
            title: exercises[index].name,
            note: appLocalizations.noteDifficultyLevel + exercises[index].difficultyLevel.toString(),
            onTap: (){
              // TODO Open editor
            }
          );
        },
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

class MobileSubmissionPage extends StatelessWidget{
  MobileSubmissionPage({super.key});

  final List<ExerciseDatamodell> items = [
    ExerciseDatamodell(id: 1, name: "Abgabe1", description: "Test1", task: "task", solution: "solution", difficultyLevel: 1),
    ExerciseDatamodell(id: 2, name: "Test2", description: "Test2", task: "task", solution: "solution", difficultyLevel: 2),
    ExerciseDatamodell(id: 3, name: "Test2", description: "Test2", task: "task", solution: "solution", difficultyLevel: 2),
    ExerciseDatamodell(id: 4, name: "Test2", description: "Test2", task: "task", solution: "solution", difficultyLevel: 2),
    ExerciseDatamodell(id: 5, name: "Test3", description: "Test3", task: "task", solution: "solution", difficultyLevel: 3),
  ];

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      // Display a list of exercises
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return MyMobileItem(
            title: items[index].name,
            note: appLocalizations.noteDifficultyLevel + items[index].difficultyLevel.toString(),
            onTap: (){
              // TODO Open editor
            }
          );
        },
      ),
    );
  }
}
