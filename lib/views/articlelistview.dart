import 'package:flutter/material.dart';
import 'package:nytimes_case/controllers/newscontroller.dart';
import 'package:nytimes_case/controllers/stillcontroller.dart';
import 'package:nytimes_case/model/newsmodel.dart';

class ArticleListView extends StatelessWidget {
  final StillController stillController = StillController();
  ArticleListView({super.key, required this.articles});
  final List<Results> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length - 3,
      itemBuilder: (context, index) {
        final article = articles[index];

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      article.title!,
                      style: stillController.headerTextStyle,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Text(
                    article.abstract!,
                    style: stillController.textStyle,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: ClipOval(
                      child: Image.network(
                    article.media!.first.mediaMetadata!.first.url!,
                    fit: BoxFit.cover,
                    height: 44,
                  )),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArticleDetailView(article: article),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Colors.black45,
              )
            ],
          ),
        );
      },
    );
  }
}

class ArticleDetailView extends StatelessWidget {
  final Results article;
  final NewsController newsController = NewsController();
  ArticleDetailView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: newsController.fetchArticle(article.url!),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: Alignment.bottomCenter, children: [
                Image.network(article.media!.first.mediaMetadata!.last.url!),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.black.withOpacity(.3),
                        Colors.black.withOpacity(.8)
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        article.title!,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          article.publishedDate!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Text(article.fullText),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
