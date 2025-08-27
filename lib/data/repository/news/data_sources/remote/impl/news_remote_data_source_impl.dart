import 'package:news/api/api_manager.dart';
import 'package:news/data/repository/news/data_sources/remote/news_remote_data_source.dart';
import 'package:news/model/news_response.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  ApiManager apiManager;

  NewsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<NewsResponse?> getSource(String sourceId) async {
    return await apiManager.getNewsBySourceId2(sourceId: sourceId);
  }
}
