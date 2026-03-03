import 'dart:io';

import 'package:code_judge_teacher/utils/exercise_datamodell.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class CodeJudgeTeacherDB {
  final Logger logger = Logger();
  Database? db;

  // ##########################################################################################
  // Declare and open the DB:
  // ##########################################################################################
  CodeJudgeTeacherDB() {
    // Chosse correct SQLite library depending on the platform
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else if(Platform.isAndroid || Platform.isIOS) {
      databaseFactory = databaseFactory;
    } else {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  }

  // Getter returning the opened DB
  Future<Database> get code_judge_teacher_db async {
    if (db != null) {
      return db!;
    }
    db = await initDB();
    return db!;
  }

  // Define the structure of the DB
  Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'CodeJudge-Teacher.db');
    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          // Table for all exercises
          await db.execute('''
            CREATE TABLE exercises(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              description TEXT,
              task TEXT,
              solution TEXT,
              hint TEXT,
              difficulty INTEGER
            );
          ''');
        },
      ),
    );
  }

  // ##########################################################################################
  // Helper functions:
  // ##########################################################################################
  // Insert an exercise with placeholders
  Future<int?> insertNewExercise() async {
    final db = await code_judge_teacher_db;
    try {
      final id = await db.insert("exercises", {
        "name": "",
        "description": "",
        "task": "",
        "solution": "",
        "hint": "",
        "difficulty": 0,
      });
      logger.i("Exercise successfully inserted");
      return id;
    } catch (e) {
      logger.e("Error: Couldn't insert a new exercise (Code 1)\n$e");
      return null;
    }
  }
  // Edit the name of an exercise
  void updateExerciseName(String name, int id) async {
    final db = await code_judge_teacher_db;
    try {
      await db.update("exercises", {"name": name}, where: "id = ?", whereArgs: [id]);
      logger.i("Name of the exercise successfully updated");
    } catch (e) {
      logger.e("ERROR: Couldn't update the name of the exercise (Code 2)\nid: $id \n$e");
    }
  }
  // Receive a list of all exercises
  Future<List<ExerciseDatamodell>?> getAllExercises() async {
    final db = await code_judge_teacher_db;
    try {
      // Receive all dishes and crete a usable list
      final exercises = await db.rawQuery("SELECT * FROM exercises");
      List<ExerciseDatamodell> convertedExercises = exercises.map((exercises) => ExerciseDatamodell(
        id: exercises["id"] as int,
        name: exercises["name"] as String,
        description: exercises["description"] as String,
        task: exercises["task"] as String,
        solution: exercises["solution"] as String,
        difficultyLevel: exercises["difficulty"] as int,
        hint: exercises["hint"] as String,
      )).toList();

      logger.i("Exercises successfully received");
      return convertedExercises;
    } catch (e) {
      logger.e("Error: Couldn't receive the exercises (Code 3)");
      return null;
    }
  }
}

// TODO:
// - Display all exercises
// - Edit all exercise values
// - Delete all exercises
// - Delete an exercise
// => Update the displayed list depending on this
