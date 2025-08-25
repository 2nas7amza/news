import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/news/cuibt/news_state.dart';
import 'package:news/ui/home/category_details/cuibt/source_state.dart';

class NewsViewModel extends Cubit<NewsState>{
  NewsViewModel():super(NewsLoadingState());

  void getSource(categoryID)async{
    try{
      emit(NewsLoadingState());
      var response=await ApiManager.getNewsBySourceId(sourceId: categoryID,);
      if(response?.status =='error'){
        emit(NewsErrorState(errorMessage: response!.message!));
        return;
      } if(response?.status =='ok'){
        emit( NewsSuccessState(newsList:response!.articles! ));
        return;
      }

    }catch(e){
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }

}