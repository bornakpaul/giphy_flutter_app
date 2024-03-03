import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:giphy_demo_app/helper/api_helper.dart';
import 'package:giphy_demo_app/models/category_list_model.dart';

part 'category_bloc_event.dart';
part 'category_bloc_state.dart';

class CategoryBloc extends Bloc<CategoryBlocEvent, CategoryBlocState> {
  CategoryBloc() : super(CategoryBlocInitialState()) {
    on<FetchCategoryBlocEvent>(_categoryLoadEvent);
  }

  FutureOr<void> _categoryLoadEvent(event, emit) async {
    try {
      emit(CategoryBlocLoadingState());
      final response = await ApiHelper().fetchCategories();
      emit(CategoryBlocLoadedState(categoryList: response));
    } catch (e) {
      emit(CategoryBlocErrorState(message: e.toString()));
    }
  }
}
