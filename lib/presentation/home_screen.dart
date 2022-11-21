import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../data/newsletter_repository.dart';
import '../util/async_value_widget.dart';
import 'html_edit_screen.dart';

class HomeScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '딥네츄럴 뉴스레터 에디터',
      home: HtmlEditorExample(title: '딥네츄럴 뉴스레터 에디터'),
    );
  }
}

class HtmlEditorExample extends ConsumerStatefulWidget {
  HtmlEditorExample({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState createState() => _HtmlEditorExampleState();
}

class _HtmlEditorExampleState extends ConsumerState<HtmlEditorExample> {
  String result = '';
  final HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    final htmlResult = ref.watch(getHtmlProvider);
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  controller.reloadWeb();
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.toggleCodeView();
          },
          child: Text(r'<\>',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        body: AsyncValueWidget(
          value: htmlResult,
          data: (html) => HtmlEditScreen(
            initialText: html,
            controller: controller,
          ),
        ),
      ),
    );
  }
}
