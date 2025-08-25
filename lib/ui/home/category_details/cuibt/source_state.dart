import 'package:news/model/source_response.dart';

abstract class SourceState{}
class SourceLoadingState extends SourceState{}
class SourceInitialState extends SourceState{}
class SourceSuccessState extends SourceState{
  List< Source> sourceList;
  SourceSuccessState({required this.sourceList});
}
class SourceErrorState extends SourceState{
  String errorMessage;
  SourceErrorState({required this.errorMessage});
}