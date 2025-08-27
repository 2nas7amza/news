//todo: interface =>source locale data source
import 'package:hive/hive.dart';
import 'package:news/model/source_response.dart';

import '../source_local_data_source.dart';

class SourceLocalDataSourceImpl implements SourceLocalDataSource {
  static const String sourceTab = 'SourceTab';

  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    // TODO: implement getSources
    var box = await Hive.openBox(sourceTab);
    return box.get(categoryId);
  }

  @override
  void saveSources(SourceResponse? sourceResponse, String categoryId) async {
    // TODO: implement saveSources
    var box = await Hive.openBox(sourceTab);
    await box.put(categoryId, sourceResponse);
    await box.close();
  }
}
