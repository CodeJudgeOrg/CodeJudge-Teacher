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

import 'package:code_judge_teacher/main.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatelessWidget {
  final Widget body;
  final ScreenType screenType;
  final String title;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<MyNavigationBarItemData> items;

  const MyNavigationBar({
    super.key,
    required this.body,
    required this.screenType,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
    this.title = 'CodeJudge',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (screenType == ScreenType.desktop) {
      return Scaffold(
        body: Row(
          children: [
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [BoxShadow(blurRadius: 12, spreadRadius: 2)],
              ),
              child: Column(
                children: [
                  for (int i = 0; i < items.length - 1; i++)
                    MyNavigationBarItem(
                      icon: items[i].icon,
                      label: items[i].label,
                      selected: selectedIndex == i,
                      onTap: () => onItemSelected(i),
                    ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 4),
                    child: Divider(thickness: 1, height: 1, color: theme.colorScheme.primary),
                  ),
                  MyNavigationBarItem(
                    icon: items.last.icon,
                    label: items.last.label,
                    selected: selectedIndex == items.length - 1,
                    onTap: () => onItemSelected(items.length - 1),
                  ),
                ],
              ),
            ),
            VerticalDivider(thickness: 1, width: 1, color: theme.colorScheme.primary),
            Expanded(child: body),
          ],
        ),
      );
    } else if (screenType == ScreenType.tablet) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              backgroundColor: theme.colorScheme.surface,
              selectedIndex: selectedIndex,
              labelType: NavigationRailLabelType.all,
              selectedIconTheme: IconThemeData(color: theme.colorScheme.primary, size: 30),
              unselectedIconTheme: IconThemeData(color: theme.colorScheme.outline, size: 25),
              selectedLabelTextStyle: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
              unselectedLabelTextStyle: TextStyle(color: theme.colorScheme.outline),
              onDestinationSelected: onItemSelected,
              destinations: [
                for (final item in items)
                  NavigationRailDestination(icon: Icon(item.icon), label: Text(item.label)),
              ],
            ),
            VerticalDivider(thickness: 1, width: 1, color: theme.colorScheme.primary),
            Expanded(child: body),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text(title), backgroundColor: theme.colorScheme.primaryContainer),
        drawer: Drawer(
          backgroundColor: theme.colorScheme.surface,
          child: Column(
            children: [
              DrawerHeader(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'CodeJudge',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    for (int i = 0; i < items.length - 1; i++)
                      MyNavigationBarItem(
                        icon: items[i].icon,
                        label: items[i].label,
                        selected: selectedIndex == i,
                        onTap: () => onItemSelected(i),
                      ),
                    const Spacer(),
                    Divider(thickness: 1, height: 1),
                    MyNavigationBarItem(
                      icon: items.last.icon,
                      label: items.last.label,
                      selected: selectedIndex == items.length - 1,
                      onTap: () => onItemSelected(items.length - 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: body,
      );
    }
  }
}

class MyNavigationBarItemData {
  final IconData icon;
  final String label;

  const MyNavigationBarItemData({
    required this.icon,
    required this.label,
  });
}

class MyNavigationBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const MyNavigationBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: selected ? theme.colorScheme.primary.withOpacity(0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: selected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.8),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontFamily: "SourceCodePro",
                  fontSize: 15,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
