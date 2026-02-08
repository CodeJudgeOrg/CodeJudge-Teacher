import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/main.dart';
import 'package:code_judge_teacher/pages/add_or_edit_exercise_page.dart';
import 'package:code_judge_teacher/pages/settings_page.dart';
import 'package:code_judge_teacher/ui_elements/my_list_items.dart';
import 'package:code_judge_teacher/ui_elements/my_navigation_bar.dart';
import 'package:code_judge_teacher/utils/exercise_datamodell.dart';
import 'package:code_judge_teacher/utils/global_variables.dart';
import 'package:flutter/material.dart';

class TabletLayout extends StatefulWidget{

  const TabletLayout({super.key});

  @override
  State<TabletLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<TabletLayout> {
  Widget getSelectedPage() {
    switch (selectedIndexInNavigationBar) {
      case 0:
        return TabletSubmissionPage();
      case 1:
        return TabletExercisePage();
      default:
        return Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyNavigationBar(
      body: getSelectedPage(),
      screenType: ScreenType.tablet,
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

// Exercise section
class TabletExercisePage extends StatelessWidget{
  TabletExercisePage({super.key});

  final List<ExerciseDatamodell> items = [
    ExerciseDatamodell(name: "Test1", description: "Test1", task: "task", solution: "solution", difficultyLevel: 1),
    ExerciseDatamodell(name: "Test2", description: "Test2", task: "task", solution: "solution", difficultyLevel: 2),
    ExerciseDatamodell(name: "Test2", description: "Test2", task: "task", solution: "solution", difficultyLevel: 2),
    ExerciseDatamodell(name: "Test2", description: "Test2", task: "task", solution: "solution", difficultyLevel: 2),
    ExerciseDatamodell(name: "Test3", description: "Test3", task: "task", solution: "solution", difficultyLevel: 3),
  ];

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      // Display a list of exercises
      body: Positioned.fill(
        child: GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(16),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: List.generate(
            items.length,
            (index) {
              return MyDesktopAndTabletItem(
                title: items[index].name,
                note: appLocalizations.noteDifficultyLevel + items[index].difficultyLevel.toString(),
                onTap: (){
                  // TODO Open editor
                }
              );
            }
          ),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_rounded),
        label: Text(appLocalizations.newExercise), // New
        onPressed: () {
          // Open a page to add a new exercise
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddOrEditExercisePage(isEditingAnExercise: false)));
        },
      ),
    );
  }
}

// Seubmissions section
class TabletSubmissionPage extends StatelessWidget{
  TabletSubmissionPage({super.key});

  final List<ExerciseDatamodell> items = [
    ExerciseDatamodell(name: "Abgabe1", description: "Test1", task: "task", solution: "solution", difficultyLevel: 1),
    ExerciseDatamodell(name: "Test2", description: "Test2", task: "task", solution: "solution", difficultyLevel: 2),
    ExerciseDatamodell(name: "Test2", description: "Test2", task: "task", solution: "solution", difficultyLevel: 2),
    ExerciseDatamodell(name: "Test2", description: "Test2", task: "task", solution: "solution", difficultyLevel: 2),
    ExerciseDatamodell(name: "Test3", description: "Test3", task: "task", solution: "solution", difficultyLevel: 3),
  ];

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      // Display a list of exercises
      body: Positioned.fill(
        child: GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(16),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: List.generate(
            items.length,
            (index) {
              return MyDesktopAndTabletItem(
                title: items[index].name,
                note: appLocalizations.noteDifficultyLevel + items[index].difficultyLevel.toString(),
                onTap: (){
                  // TODO Open editor
                }
              );
            }
          ),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_rounded),
        label: Text(appLocalizations.newExercise), // New
        onPressed: () {
          // TODO Open layout to add an exercise
        },
      ),
    );
  }
}
