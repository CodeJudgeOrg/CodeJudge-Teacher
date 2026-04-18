import 'dart:convert';

import 'package:code_judge_library/datamodels.dart';
import 'package:code_judge_teacher/utils/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiConnector {
    // Always use the same instance
    static final ApiConnector instance = ApiConnector.internal();
    factory ApiConnector() => instance;
    ApiConnector.internal();

    final String baseURL = "http://127.0.0.1:8000/teacher";

    // Upload a list of exercises
    void uploadExercises(BuildContext context) async {
        final url = Uri.parse("$baseURL/uploadExercises");

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

    // Download all submissions and update the list
    void receiveSubmissions(BuildContext context) async {
        final url = Uri.parse("$baseURL/receiveSubmissions");

        final response = await http.get(url);
        List<dynamic> decodedResponse = jsonDecode(response.body);
        final List<SubmissionDatamodel> submissions = decodedResponse.map((item) {
            return SubmissionDatamodel(
                exerciseName: item["exerciseName"],
                task: item["task"],
                code: item["code"],
                output: item["output"],
                studentName: item["studentName"]
            );
        }).toList();

        context.read<SubmissionProvider>().refreshSubmissions(submissions);
    }
}

// TODO: Improve error handling and display a SnackBar!