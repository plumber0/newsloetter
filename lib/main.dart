import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_editor/data/newsletter_repository.dart';
import 'package:html_editor/presentation/html_edit_screen.dart';
import 'package:html_editor/util/async_value_widget.dart';
import 'package:html_editor_enhanced/html_editor.dart';

void main() async {
  registerErrorHandlers();
  runApp(ProviderScope(child: HtmlEditorExampleApp()));
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('알 수 없는 오류가 발생했어요!'),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}

class HtmlEditorExampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '딥네츄럴 뉴스레터 생성기',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
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
