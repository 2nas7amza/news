
import 'package:news/model/news_response.dart';

abstract class NewsState{}
class NewsLoadingState extends NewsState{}
class NewsInitialState extends NewsState{}
class NewsSuccessState extends NewsState{
  List< Articles> newsList;
  NewsSuccessState({required this.newsList});
}
class NewsErrorState extends NewsState{
  String errorMessage;
  NewsErrorState({required this.errorMessage});
}