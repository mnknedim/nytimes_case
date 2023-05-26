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
  ArticleDetailView({super.key, required this.article});

  late String? abstractText = "";
  late String? leadparagraph = "";
  final Results article;
  NewsController newsController = NewsController();
  final StillController stillController = StillController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: newsController.fetchArticle(article.url!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Hata durumunda kullanıcıya bir hata mesajı veya hata sayfası gösterebilirsiniz
            return Text('Hata: ${snapshot.error}');
          } else {
            abstractText = snapshot.data!.abstract;
            leadparagraph = snapshot.data!.leadParagraph;
            return Container(
              margin: const EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                          article.media!.first.mediaMetadata!.last.url!),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.all(8.0),
                              child: Card(
                                  child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 15,
                                ),
                              )),
                            ),
                          ),
                          const SizedBox(
                            height: 120,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            height: 75,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(.3),
                                  Colors.black.withOpacity(.9),
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  article.title!,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 11,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  article.publishedDate!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(snapshot.data!.abstract!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                letterSpacing: 1)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(snapshot.data!.leadParagraph!,
                            style:
                                const TextStyle(fontSize: 14, wordSpacing: 3)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
