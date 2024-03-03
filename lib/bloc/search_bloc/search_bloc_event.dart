part of 'search_bloc.dart';

abstract class SearchBlocEvent extends Equatable {
  const SearchBlocEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryEvent extends SearchBlocEvent {
  final String query;

  const SearchQueryEvent({
    required this.query,
  });
}

class SearchQueryResetEvent extends SearchBlocEvent {
  const SearchQueryResetEvent();
}
