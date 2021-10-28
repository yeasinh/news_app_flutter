import 'package:news_api/data_model.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  Future<DataModel> fetchArticleByID(String id) async {
    var client = http.Client();
    var url = Uri.parse("https://hacker-news.firebaseio.com/v0/item/$id.json");

    var response = await client.get(url);
    print("individual id ${response.statusCode}");

    DataModel dataModel = dataModelFromJson(response.body);
    return dataModel;
    // 192327
  }

  Future<List<DataModel>> fetchIdsOfTopArticles() async {
    // List<DataModel> listOfDataModel = [];

    List<String> articleIds = [];
    var client = http.Client();
    var url =
    Uri.parse("https://hacker-news.firebaseio.com/v0/topstories.json");

    var response = await client.get(url);
    print("articles id ${response.statusCode}");
    // print(response.body);
    String res = response.body;
    res = res.replaceAll('[', "");
    res = res.replaceAll(']', "");
    articleIds = res.split(',');

    // articleIds.addAll(response.body);
    print(articleIds);
    return await fetchArticles(articleIds);
  }

  Future<List<DataModel>> fetchArticles(List<String> ids) async {
    List<DataModel> listOfDataModel = [];
    DataModel article;
    int i = 0;
    for (String id in ids) {
      if (i == 10) break;
      i++;

      article = await fetchArticleByID(id);
      listOfDataModel.add(article);
    }
    print(listOfDataModel);
    return listOfDataModel;
  }
}
