import 'package:code_judge_library/datamodels.dart';
import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/layouts/desktop_layout.dart';
import 'package:code_judge_teacher/layouts/mobile_layout.dart';
import 'package:code_judge_teacher/layouts/tablet_layout.dart';
import 'package:code_judge_teacher/utils/api_connector.dart';
import 'package:code_judge_teacher/utils/code_judge_teacher_db.dart';
import 'package:code_judge_teacher/utils/my_provider.dart';
import 'package:code_judge_teacher/utils/screen_type_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  final exerciseProvider = ExerciseProvider();
  final submissionProvider = SubmissionProvider();
  final screenTypeProvider = ScreenTypeProvider();
  // Load the settings
  final settingsProvider = SettingsController();
  settingsProvider.loadSettings;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => screenTypeProvider),
        ChangeNotifierProvider(create: (_) => exerciseProvider),
        ChangeNotifierProvider(create: (_) => submissionProvider),
        ChangeNotifierProvider(create: (_) => settingsProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Define the settings
    final settingsController = Provider.of<SettingsController>(context);
    // Define the app theme
    final ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lime, brightness: Brightness.light),
      useMaterial3: true,
    );
    final ThemeData darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lime, brightness: Brightness.dark),
      useMaterial3: true,
    );
    ScreenType screenType = context.watch<ScreenTypeProvider>().screenType;

    // Load the exercises from the DB
    getExercises(context);

    // Load the submissions
    ApiConnector().receiveSubmissions(context);

    return ScreenTypeHandler(
      child: MaterialApp(
        // Apply the theme
        title: 'CodeJudge',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: settingsController.selectedTheme,
      
        // Apply settings & language
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate
        ],
        supportedLocales: const [Locale('en'), Locale('de')],
        locale: settingsController.selectedLocale,
        home: screenType == ScreenType.desktop
          ? DesktopLayout()
          : screenType == ScreenType.tablet
            ? TabletLayout()
            : MobileLayout(),
      ),
    );
  }

  void getExercises(BuildContext context) async {
    final CodeJudgeTeacherDB db = CodeJudgeTeacherDB();
    List<ExerciseDatamodel>? exercises = await db.getAllExercises();
    if (exercises != null) {
      context.read<ExerciseProvider>().insertExercises(exercises);
    }
  }
}
