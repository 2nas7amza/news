import 'package:news/data/repository/news/data_sources/remote/news_remote_data_source.dart';
import 'package:news/data/repository/news/repository/news_repository.dart';
import 'package:news/model/news_response.dart';

class NewsRepositoryImpl implements NewsRepository {
  NewsRemoteDataSource newsRemoteDataSource;

  NewsRepositoryImpl({required this.newsRemoteDataSource});

  @override
  Future<NewsResponse?> getSources(categoryId) async {
    return await newsRemoteDataSource.getSource(categoryId);
  }
}
