import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:giphy_demo_app/helper/api_helper.dart';
import 'package:giphy_demo_app/models/search_data_model.dart';

part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  SearchBloc() : super(const SearchBlocState()) {
    on<SearchQueryEvent>(_searchQueryEvent);
    on<SearchQueryResetEvent>(_searchQueryResetEvent);
  }
  FutureOr<void> _searchQueryResetEvent(
      SearchQueryResetEvent event, Emitter emit) {
    emit(state.copyWith(
      searchedGifs: const [],
      status: FormzSubmissionStatus.initial,
      offset: 0,
      errorMessage: "",
    ));
  }

  FutureOr<void> _searchQueryEvent(SearchQueryEvent event, Emitter emit) async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final offset = state.offset + 25;

      final response = await ApiHelper().searchGifs(
        query: event.query,
        offset: offset.toString(),
      );
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        searchedGifs: response.data,
        offset: offset,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
