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
  final ValueChanged<TapDownDetails>? onLongPress;
  final ValueChanged<TapUpDetails>? onRightClick;
  final String note;

  const MyDesktopAndTabletItem({
    super.key,
    required this.title,
    required this.onTap,
    this.onLongPress,
    this.onRightClick,
    this.note = "",
  });

  @override
  Widget build(BuildContext context) {
    final theme =  Theme.of(context);
    TapDownDetails? tapDetails;

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.surfaceContainerLow,
      child: InkWell(
        onTap: onTap,
        onTapDown: (details) { // Register each tap and store its position
          tapDetails = details;
        },
        onLongPress: () {
          if (tapDetails != null && onLongPress != null) {
            onLongPress!.call(tapDetails!);
          }
        },
        onSecondaryTapUp: onRightClick != null
          ? (details) => onRightClick!.call(details)
          : null,
        borderRadius: BorderRadius.circular(12),
        splashColor: theme.colorScheme.primary.withAlpha(32), // Ripple-color at click
        hoverColor: theme.colorScheme.tertiary.withAlpha(32),  // Hover-color
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Center(
                child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(note, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200))
              ),
            ],
          )
        ),
      ),
    );
  }
}
// Styled item for the ListView
class MyMobileItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final ValueChanged<TapDownDetails>? onLongPress;
  final ValueChanged<TapUpDetails>? onRightClick;
  final String note;

  const MyMobileItem({
    super.key,
    required this.title,
    required this.onTap,
    this.onLongPress,
    this.onRightClick,
    this.note = "",
  });

  @override
  Widget build(BuildContext context) {
    final theme =  Theme.of(context);
    TapDownDetails? tapDetails;

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.surfaceContainerLow,
      child: InkWell(
        onTap: onTap,
        onTapDown: (details) { // Register each tap and store its position
          tapDetails = details;
        },
        onLongPress: () {
          if (tapDetails != null && onLongPress != null) {
            onLongPress!.call(tapDetails!);
          }
        },
        onSecondaryTapUp: onRightClick != null
          ? (details) => onRightClick!.call(details)
          : null,
        borderRadius: BorderRadius.circular(12),
        splashColor: theme.colorScheme.primary.withAlpha(32),
        hoverColor: theme.colorScheme.tertiary.withAlpha(32),
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerLeft,
          child: Row(
              children: [
                Expanded(
                  child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Text(note, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200))
              ],
            )
        ),
      ),
    );
  }
}
