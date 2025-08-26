import 'package:news/model/news_response.dart';

abstract class NewsRemoteDataSource {
  Future<NewsResponse?> getSource(String sourceId);
}
