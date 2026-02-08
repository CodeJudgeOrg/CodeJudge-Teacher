library;

import 'package:code_judge_teacher/ui_elements/my_navigation_bar.dart';
import 'package:flutter/material.dart';

int selectedIndexInNavigationBar = 0;

List<MyNavigationBarItemData> getNavigationBarItems(BuildContext context) {
  return [
    MyNavigationBarItemData(icon: Icons.code, label: "Submission"), // Submission
    MyNavigationBarItemData(icon: Icons.code, label: "Exercises"), // Exercises
    MyNavigationBarItemData(icon: Icons.settings, label: "Settings"), // Settings
  ];
}
