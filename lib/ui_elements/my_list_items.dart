/// Copyright 2026 Fabian Roland (naibaf-1)

/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at

/// http://www.apache.org/licenses/LICENSE-2.0

/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/material.dart';

// Styled item for the GridView
class MyDesktopAndTabletItem extends StatelessWidget{
  final String title;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final String note;

  const MyDesktopAndTabletItem({
    super.key,
    required this.title,
    required this.onTap,
    this.onLongPress,
    this.note = "",
  });

  @override
  Widget build(BuildContext context) {
    final theme =  Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.surfaceContainerLow,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        splashColor: theme.colorScheme.surfaceContainerHigh, // Ripple-color at click
        hoverColor: theme.colorScheme.surfaceContainer,  // Hover-color
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Center(child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              Positioned(bottom: 0, right: 0, child: Text(note, style: TextStyle(fontSize: 12))),
            ],
          )
        ),
      ),
    );
  }
}
// Styled item for the ListView
class MyMobileItem extends StatelessWidget {
  final title;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final String note;

  MyMobileItem({
    required this.title,
    required this.onTap,
    this.onLongPress,
    this.note = "",
  });

  @override
  Widget build(BuildContext context) {
    final theme =  Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.surfaceContainerLow,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        splashColor: theme.colorScheme.surfaceContainerHigh,
        hoverColor: theme.colorScheme.surfaceContainer,
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerLeft,
          child: Stack(
              children: [
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Positioned(bottom: 0, right: 0, child: Text(note, style: TextStyle(fontSize: 12))),
              ],
            )
        ),
      ),
    );
  }
}
