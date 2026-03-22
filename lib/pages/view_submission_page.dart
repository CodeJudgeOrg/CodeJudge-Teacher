import 'package:code_judge_library/code_judge_task_box.dart';
import 'package:flutter/material.dart';

class ViewSubmissionPage extends StatelessWidget{
  final String task;
  final String submission;
  final String studentName;

  const ViewSubmissionPage({
    super.key,
    required this.task,
    required this.submission,
    required this.studentName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Submission by $studentName"), // TODO Translate
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: CodeJudgeTaskBox(
        task: task,
        child: Text(
          submission,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}