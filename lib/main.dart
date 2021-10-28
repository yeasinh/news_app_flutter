import 'package:news_api/api_management.dart';
import 'package:news_api/data_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiManager apiManager = ApiManager();
  List<int> ids = [
    9129911,
    9129199,
    9127761,
    9128141,
    9128264,
    9127792,
    9129248,
    9127092,
    9128367
  ];

  Future<DataModel>? dataModel;
  Future<List<DataModel>>? articles;
  @override
  void initState() {
    articles = apiManager.fetchIdsOfTopArticles();
    // dataModel = apiManager.fetchArticleByID(9130144);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
      ),
      body: FutureBuilder<List<DataModel>>(
          future: articles,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("something went wrong");
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.data![i].title ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            Text(
                              snapshot.data![i].text ?? "",
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  snapshot.data![i].by ?? "",
                                ),
                                Text(
                                  snapshot.data![i].score.toString(),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }
          }),
    );
  }
}
