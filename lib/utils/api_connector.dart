import 'dart:convert';

import 'package:code_judge_library/exercise_datamodel.dart';
import 'package:code_judge_teacher/utils/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiConnector {
    // Always use the same instance
    static final ApiConnector instance = ApiConnector.internal();
    factory ApiConnector() => instance;
    ApiConnector.internal();

    final String baseURL = "http://127.0.0.1:8000";

    // Upload a list of exercises
    void uploadExercises(BuildContext context) async {
        final url = Uri.parse("$baseURL/teacher/uploadExercises");

        final List<ExerciseDatamodel> exercises = context.read<ExerciseProvider>().getSelectedExercises();
        final List<Map<String, dynamic>> exercises2 = [];
        final int itemCount = exercises.length;

        for (var i = 0; i < itemCount; i++) {
            exercises2.add({
                "name": exercises[i].name,
                "description": exercises[i].description,
                "task": exercises[i].task,
                "solution": exercises[i].solution,
                "hint": exercises[i].hint,
                "difficulty": exercises[i].difficultyLevel,
            });
        }

        // Upload the exercises
        final response = await http.post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(exercises2)
        );

        // Log the result
        print("Status: ${response.statusCode}\nBody: ${response.body}");
    }
}

// TODO: Improve error handling and display a SnackBar!