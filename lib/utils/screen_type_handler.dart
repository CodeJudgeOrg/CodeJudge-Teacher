import 'package:code_judge_teacher/utils/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ScreenType {mobile, tablet, desktop}

class ScreenTypeHandler extends StatelessWidget{
  final Widget child;

  const ScreenTypeHandler({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        // For desktops
        if (constrains.maxWidth >= 1200) {
          updateScreenType(context, ScreenType.desktop);
        }
        // For tablets
        else if (constrains.maxWidth >= 900) {
          updateScreenType(context, ScreenType.tablet);
        }
        // Else it's a mobile phone
        else {
          updateScreenType(context, ScreenType.mobile);
        }

        return child;
      }
    );
  }

  void updateScreenType(BuildContext context, ScreenType newScreenType) {
    // Update after the build was completed
    final provider = context.read<ScreenTypeProvider>();
    if (newScreenType != provider.screenType) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.changeScreenType(newScreenType);
      });
    }
  }
}

// TODO Das ums ganze MaterialApp in main => ALLE Seiten über den Provider laden!