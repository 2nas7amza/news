import '../../../../../model/source_response.dart';

abstract class SourceRemoteDataSource {
  Future<SourceResponse?> getSource(String categoryId);
}
