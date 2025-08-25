
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/news_response.dart';
import '../model/source_response.dart';
import 'api_constants.dart';
import 'end_points.dart';

//https://newsapi.org/v2/top-headlines/sources?apiKey=4b64a2bcfc604bc8bc2652f265b27b3f
//https://newsapi.org/v2/everything?q=bitcoin&apiKey=4b64a2bcfc604bc8bc2652f265b27b3f
class ApiManager {
  static Future<SourceResponse?> getSources(
      String categoryID,
      ) async {
    // authority => The domain name of the server
    // unencodedPath => The path to the resource on the server
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
      'apiKey': ApiConstants.apiKey,
      'category': categoryID,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<NewsResponse?> getNewsBySourceId({
    required String sourceId,
    int page = 1,
    int pageSize = 20,
    String? query,
  }) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
      'page': page.toString(),
      'pageSize': pageSize.toString(),
      if (query != null && query.isNotEmpty) 'q': query,
    });

    try {
      var response = await http.get(url);
      var responseBody = response.body;
      return NewsResponse.fromJson(jsonDecode(responseBody));
    } catch (e) {
      throw Exception(e);
    }
  }
}
