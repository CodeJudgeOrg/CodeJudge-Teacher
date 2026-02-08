import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/utils/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeFocusNode = FocusNode();
    final settingsController = Provider.of<SettingsController>(context);
    final currentMode = settingsController.selectedTheme;
    final currentLocalization = settingsController.selectedLocale?.languageCode ?? 'system';
    final appLocalizations = AppLocalizations.of(context)!; // Get translation

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.settings), // Settings
        backgroundColor: theme.colorScheme.primaryContainer,
      ), //Title: Settings
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: ListTile(
              title: Text(appLocalizations.themeMode), // Theme Mode:
              trailing: SizedBox(
                width: 86,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ThemeMode>(
                    focusNode: themeFocusNode,
                    value: currentMode,
                    onChanged: (mode) {
                      settingsController.applyTheme(mode!);
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    items: [
                      DropdownMenuItem(value: ThemeMode.system, child: Text(appLocalizations.system)), // System
                      DropdownMenuItem(value: ThemeMode.light, child: Text(appLocalizations.lightMode)), // Light
                      DropdownMenuItem(value: ThemeMode.dark, child: Text(appLocalizations.darkMode)), // Dark
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ListTile(
              title: Text(appLocalizations.localisationMode), // Language:
              trailing: SizedBox(
                width: 86,
                child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  focusNode: themeFocusNode,
                  value: currentLocalization,
                  onChanged: (value) {
                      if (value == 'system') {
                        settingsController.applyLanguage(null);
                      } else {
                        settingsController.applyLanguage(Locale(value!));
                      }
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  items: [
                      DropdownMenuItem(value: 'system', child: Text(appLocalizations.system)), // System
                      DropdownMenuItem(value: 'en', child: Text(appLocalizations.localeEnglish)), // English
                      DropdownMenuItem(value: 'de', child: Text(appLocalizations.localeGerman)), // German
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Divider(thickness: 1, height: 1),
          Container(
            padding: const EdgeInsets.all(12),
            color: theme.colorScheme.surfaceContainerHigh,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/icon/app_icon.png", scale: 10),
                TextButton(
                  child: Text(appLocalizations.aboutThisButton), // About this project
                  onPressed: () {
                    openLink("https://github.com/CodeJudgeOrg/CodeJudge-Teacher#readme");
                  },
                ),
                TextButton(
                  child: Text(appLocalizations.seeLicenseButton), // See the license
                  onPressed: () {
                    openLink("https://github.com/CodeJudgeOrg/CodeJudge-Teacher?tab=Apache-2.0-1-ov-file#readme");
                  },
                ),
                TextButton(
                  child: Text(appLocalizations.reportABugButton), // Report a bug
                  onPressed: () {
                    openLink("https://github.com/CodeJudgeOrg/CodeJudge-Teacher/issues/new?template=bug-report-for-codejudge.md");
                  },
                ),
                TextButton(
                  child: Text(appLocalizations.requestAFeatureButton), // Request a feature
                  onPressed: () {
                    openLink("https://github.com/CodeJudgeOrg/CodeJudge-Teacher/issues/new?template=feature-request-for-codejudge.md");
                  },
                ),
                TextButton(
                  child: Text(appLocalizations.seeReleasesButton), // See all releases
                  onPressed: () {
                    openLink("https://github.com/CodeJudgeOrg/CodeJudge-Teacher/releases");
                  },
                ),
                TextButton(
                  child: Text(appLocalizations.aboutMeButton), // About the developer
                  onPressed: () {
                    openLink("https://github.com/naibaf-1");
                  },
                ),
              ],
            )
          )
        ],
      ),
    );
  }

  // Open a link in the browser
  void openLink(String link) async {
    final url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }
}
