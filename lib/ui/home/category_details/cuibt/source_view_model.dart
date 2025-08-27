import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/data/repository/sources/repository/source_repository.dart';
import 'package:news/model/source_response.dart';
import 'package:news/ui/home/category_details/cuibt/source_state.dart';

class SourceViewModel extends Cubit<SourceState>{
  SourceRepository sourceRepository;

  SourceViewModel({required this.sourceRepository})
    : super(SourceLoadingState());

  void getSource(categoryID)async{
    try{
      emit(SourceLoadingState());
      var response = await sourceRepository.getSources(categoryID);
      if(response?.status =='error'){
      emit(SourceErrorState(errorMessage: response!.message!));
      return;
     } if(response?.status =='ok'){
       emit(SourceSuccessState(sourceList: response!.sources!));
       return;
     }

    }catch(e){
      emit(SourceErrorState(errorMessage: e.toString()));
    }
  }

}