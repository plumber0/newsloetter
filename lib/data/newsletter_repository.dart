import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class NewsLetterRepository {
  NewsLetterRepository({required this.endpoint});

  final String endpoint;

  Future<String> getHtml() async {
    var url = Uri.https(endpoint, 'newsletter');
    var response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('데이터를 가져오는데 실패했어요!');
    }
    final result = jsonDecode(utf8.decode(response.bodyBytes));
    await Future.delayed(const Duration(seconds: 1));
    return result['html_content'];
  }
}

final NewsLetterProvider = Provider<NewsLetterRepository>((ref) {
  const endpoint = String.fromEnvironment('endpoint');
  if (endpoint=='staging.data.deepnatural.ai') {
    return NewsLetterRepository(endpoint: endpoint);
  } else {
    return NewsLetterRepository(endpoint: 'staging.data.deepnatural.ai');
  }
});

final getHtmlProvider = FutureProvider<String>((ref) async {
  final newsLetterRepository = ref.watch(NewsLetterProvider);
  return newsLetterRepository.getHtml();
});
