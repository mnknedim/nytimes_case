import 'package:flutter/material.dart';
import 'package:nytimes_case/model/newsmodel.dart';
import 'package:nytimes_case/views/articlelistview.dart';

import 'controllers/newscontroller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Probe',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final NewsController newsController = NewsController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text(
          'NY Times Most Popular',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                items: [
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Last 1 Day'),
                  ),
                  const PopupMenuItem(
                    value: 3,
                    child: Text('Last 3 Day'),
                  ),
                  const PopupMenuItem(
                    value: 7,
                    child: Text('Last 7 Day'),
                  ),
                ],
                elevation: 8,
              ).then((value) {
                // Dropdown menüsünden bir seçenek seçildiğinde yapılacak işlemler
                if (value == 1) {
                  // Seçenek 1 seçildiğinde yapılacak işlemler
                } else if (value == 2) {
                  // Seçenek 2 seçildiğinde yapılacak işlemler
                }
              });
            },
            icon: const Icon(Icons.bubble_chart),
          ),
        ],
      ),
      body: FutureBuilder<List<Results>>(
        future: newsController.fetchMostPopularArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else {
            final articles = snapshot.data!;

            return ArticleListView(articles: articles);
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Center(
                child: Text(
                  'Menü',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Ana Sayfa'),
              onTap: () {
                // Ana sayfaya yönlendirme yapabilirsiniz
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ayarlar'),
              onTap: () {
                // Ayarlar sayfasına yönlendirme yapabilirsiniz
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Hakkında'),
              onTap: () {
                // Hakkında sayfasına yönlendirme yapabilirsiniz
              },
            ),
          ],
        ),
      ),
    );
  }
}
