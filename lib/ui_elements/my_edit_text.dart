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

// Customised TextField
class MyEditText extends StatefulWidget {
  final bool multiline;
  final bool autocorrect;
  final bool suggestions;
  final bool autofocus;
  final TextInputType textInputType;
  final String hint;
  final TextEditingController controller;

  const MyEditText({
    super.key,
    required this.hint,
    required this.controller,
    this.multiline = true,
    this.suggestions = false,
    this.autocorrect = false,
    this.autofocus = true,
    this.textInputType = TextInputType.text,
  });

  @override
  State<MyEditText> createState() => _MyEditTextState();
}

class _MyEditTextState extends State<MyEditText> {

  @override
  void initState() {
    super.initState();
    // Cursor at the end
    widget.controller.selection = TextSelection.fromPosition(TextPosition(offset: widget.controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    final int? maxLines = widget.multiline ? null : 1;

    return TextField(
      controller: widget.controller,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.suggestions,
      autofocus: widget.autofocus,
      maxLines: maxLines,

      textInputAction: widget.multiline ? TextInputAction.newline : TextInputAction.done,

      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
        hintStyle: TextStyle(color: Theme.of(context).hintColor),
      ),
    );
  }
}
