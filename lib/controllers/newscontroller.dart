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

      // final results = json['results'];

      // for (var result in results) {
      //   Results article = Results(
      //     title: result['title'],
      //     abstract: result['abstract'],
      //     image: result['media'][0]['media-metadata'][0]['url'],
      //     publishedDate: result['published_date'],
      //     fullText: '', // You might need to fetch full text separately
      //   );

      //   articles.add(article);
      // }

      // Sort articles based on published date
      articles.sort((a, b) => b.publishedDate!.compareTo(a.publishedDate!));

      return articles;
    } else {
      throw Exception('Failed to fetch articles');
    }
  }

  Future<String> fetchArticle(String bodyUrl) async {
    String apiKey = 'W560QuA7l0omPBc0fqu9VfMDOzPyDbMB';
    String articleId = bodyUrl;

    var url = Uri.parse(
        'https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=$apiKey&q=$articleId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var paragraphs = jsonData['response']['docs'][0]['body'];

      for (var paragraph in paragraphs) {
        print('Paragraf: $paragraph');
        print('---');
      }
    } else {
      print('Hata: ${response.statusCode}');
    }

    return "";
  }
}
