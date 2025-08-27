import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news/data/repository/sources/data_sources/local/source_local_data_source.dart';
import 'package:news/data/repository/sources/data_sources/remote/SourceRemoteDataSource.dart';
import 'package:news/model/source_response.dart';

import '../source_repository.dart';

class SourceRepositoryImpl implements SourceRepository {
  SourceRemoteDataSource sourceRemoteDataSource;
  SourceLocalDataSource sourceLocalDataSource;

  SourceRepositoryImpl(
      {required this.sourceRemoteDataSource, required this.sourceLocalDataSource});

  @override
  Future<SourceResponse?> getSources(categoryId) async {
    //todo: internet=> remote ds
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());

// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      var sourceResponse = await sourceRemoteDataSource.getSource(categoryId);
      sourceLocalDataSource.saveSources(sourceResponse, categoryId);
      return sourceResponse;
    } else {
      //todo: no internet=> local ds
      return await sourceLocalDataSource.getSources(categoryId);
    }
  }
}
