//todo: interface source remote data source (ds)
import 'package:news/api/api_manager.dart';

import '../../../../../../model/source_response.dart';
import '../SourceRemoteDataSource.dart';

class SourceRemoteDataSourceImpl implements SourceRemoteDataSource {
  ApiManager apiManager;

  SourceRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<SourceResponse?> getSource(String categoryId) async {
    return await apiManager.getSources(categoryId);
  }
}
