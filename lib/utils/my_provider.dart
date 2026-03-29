import 'package:code_judge_library/exercise_datamodel.dart';
import 'package:code_judge_teacher/utils/screen_type_handler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Apply the settings to the whole app
class SettingsController extends ChangeNotifier {
  ThemeMode _selectedTheme = ThemeMode.system;
  ThemeMode get selectedTheme => _selectedTheme;
  Locale? _selectedLocale;
  Locale? get selectedLocale => _selectedLocale;
  
  // Get the applied settings from the preferences
  Future<void> loadSettings() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final localeCode = sharedPreferences.getString('selected_locale');
    final themeCode = sharedPreferences.getString('selected_theme');

    // Set correct localisation
    if (localeCode != null) {
      _selectedLocale = Locale(localeCode);
    } else {
      _selectedLocale = null; // System language
    }
    // Set correct theme
    if (themeCode == "light") {
      _selectedTheme = ThemeMode.light;
    } else if (themeCode == "dark") {
      _selectedTheme = ThemeMode.dark;
    } else {
      _selectedTheme = ThemeMode.system;
    }
    notifyListeners();
  }

  // Apply correct theme
  Future<void> applyTheme(ThemeMode mode) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (mode == ThemeMode.system) {
      await sharedPreferences.remove('selected_theme');
    } else if (mode == ThemeMode.light){
      await sharedPreferences.setString('selected_theme', 'light');
    } else {
      await sharedPreferences.setString('selected_theme', 'dark');
    }
    _selectedTheme = mode;
    notifyListeners();
  }

  // Apply the correct language
  Future<void> applyLanguage(Locale? locale) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (locale == null) {
      await sharedPreferences.remove('selected_locale');
      _selectedLocale = null;
    } else {
      await sharedPreferences.setString('selected_locale', locale.languageCode);
      _selectedLocale = locale;
    }
    notifyListeners();
  }
}

// Store and update the displayed list of exercises
class ExerciseProvider extends ChangeNotifier {
  List<ExerciseDatamodel> exercises = [];
  bool showSelectionBar = false;

  // Insert an exercise
  void insertExercise(ExerciseDatamodel exercise) {
    exercises.add(exercise);
    notifyListeners();
  }

  // Insert all exercises
  void insertExercises(List<ExerciseDatamodel> newExercises) {
    exercises..clear()..addAll(newExercises);
    notifyListeners();
  }

  // Edit an exercise
  void editExercise(ExerciseDatamodel exercise, int position) {
    exercises..removeAt(position)..insert(position, exercise);
    notifyListeners();
  }

  // Delete an exercise
  void deleteExercise(int id) {
    exercises.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  // Select or unselect an exercise
  void toggleSelectionOfExercise(int position, bool select) {
    exercises[position].isSelected = select;

    if (select) {
      // Show the AppBar
      showSelectionBar = true;
    } else {
      // If no other exercise is selected, hide the AppBar
      if (!exercises.any((exercise) => exercise.isSelected == true)) {
        showSelectionBar = false;
      }
    }

    notifyListeners();
  }

  // Unselect all exercises at once
  void unselectAllExercises() {
    int itemCount = exercises.length;
    for (int i = 0; i < itemCount; i++) {
      exercises[i].isSelected = false;
    }
    // Hide the AppBar
    showSelectionBar = false;

    notifyListeners();
  }
}

// Update the layout of all pages depending on the screen size
class ScreenTypeProvider extends ChangeNotifier {
  ScreenType screenType = ScreenType.tablet;

  void changeScreenType (ScreenType newScreenType) {
    screenType = newScreenType;
    notifyListeners();
  }
}
