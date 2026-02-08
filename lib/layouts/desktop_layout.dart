import 'package:code_judge_teacher/main.dart';
import 'package:code_judge_teacher/ui_elements/my_navigation_bar.dart';
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
        return Placeholder();
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
          //TODO Open settings
        }
      },
      items: getNavigationBarItems(context),
    );
  }
}

