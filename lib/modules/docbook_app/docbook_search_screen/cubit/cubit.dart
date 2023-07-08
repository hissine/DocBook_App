
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramdan_proj/models/docbook_app/searchmodel.dart';
import 'package:ramdan_proj/modules/docbook_app/docbook_search_screen/cubit/states.dart';
import 'package:ramdan_proj/shared/network/remote/dio_helper/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? model;
  void search(String specialty){
    emit(SearchLoadingState());
    DioHelper.getData(
        url: 'home/doctor/$specialty',
    ).then((value) {
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
  void searchWithName(String? specialty,String? name){
    emit(SearchNameLoadingState());
    DioHelper.getData(
        url: 'home/search/$specialty/specialtyanduserName/$name',
    ).then((value) {
      model=SearchModel.fromJson(value.data);
      emit(SearchNameSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchNameErrorState());
    });
  }

}