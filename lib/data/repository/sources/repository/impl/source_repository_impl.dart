import 'package:news/data/repository/sources/data_sources/remote/SourceRemoteDataSource.dart';
import 'package:news/model/source_response.dart';

import '../source_repository.dart';

class SourceRepositoryImpl implements SourceRepository {
  SourceRemoteDataSource sourceRemoteDataSource;

  SourceRepositoryImpl({required this.sourceRemoteDataSource});

  @override
  Future<SourceResponse?> getSources(categoryId) async {
    return await sourceRemoteDataSource.getSource(categoryId);
  }
}
