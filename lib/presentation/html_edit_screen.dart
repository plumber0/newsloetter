import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HtmlEditScreen extends ConsumerWidget {
  const HtmlEditScreen({
    required this.controller,
    Key? key,
  }) : super(key: key);
  final HtmlEditorController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          HtmlEditor(
            controller: controller,
            htmlEditorOptions: HtmlEditorOptions(),
          ),
        ],
      ),
    );
  }
}
