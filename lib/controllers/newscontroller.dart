import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/newsmodel.dart';

class NewsController {
  Future<List<Results>> fetchMostPopularArticles() async {
    const String apiKey = 'W560QuA7l0omPBc0fqu9VfMDOzPyDbMB';
    const String url =
        'https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      var news_generated = NewsGenerated.fromJson(json);

      List<Results> articles = news_generated.results!.toList();

      // Sort articles based on published date
      articles.sort((a, b) => b.publishedDate!.compareTo(a.publishedDate!));

      return articles;
    } else {
      throw Exception('Failed to fetch articles');
    }
  }

  Future<ArticleDetay> fetchArticle(String bodyUrl) async {
    String apiKey = 'W560QuA7l0omPBc0fqu9VfMDOzPyDbMB';
    String articleId = bodyUrl;
    late ArticleDetay articleDetay;
    var url = Uri.parse(
        'https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=$apiKey&q=$articleId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var paragraphs = jsonData['response']['docs'][0];
      articleDetay = ArticleDetay(
          abstract: paragraphs['abstract'].toString(),
          leadParagraph: paragraphs['lead_paragraph'].toString());
    } else {
      print('Hata: ${response.statusCode}');
    }
    return articleDetay;
  }
}
