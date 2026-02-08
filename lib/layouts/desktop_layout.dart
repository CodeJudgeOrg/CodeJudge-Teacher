import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/main.dart';
import 'package:code_judge_teacher/pages/settings_page.dart';
import 'package:code_judge_teacher/ui_elements/my_list_items.dart';
import 'package:code_judge_teacher/ui_elements/my_navigation_bar.dart';
import 'package:code_judge_teacher/utils/exercise_datamodell.dart';
import 'package:code_judge_teacher/utils/global_variables.dart';
import 'package:flutter/material.dart';

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
    return MyNavigationBar(
      body: getSelectedPage(),
      screenType: ScreenType.desktop,
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
  DesktopExercisePage({super.key});

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
          crossAxisCount: 5,
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

class DesktopSubmissionPage extends StatelessWidget{
  DesktopSubmissionPage({super.key});

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
          crossAxisCount: 5,
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
