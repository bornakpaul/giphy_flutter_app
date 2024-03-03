// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'search_bloc.dart';

class SearchBlocState extends Equatable {
  final FormzSubmissionStatus status;
  final List<SearchDataModel> searchedGifs;
  final int offset;
  final String errorMessage;
  const SearchBlocState({
    this.status = FormzSubmissionStatus.initial,
    this.searchedGifs = const [],
    this.offset = 0,
    this.errorMessage = "",
  });

  SearchBlocState copyWith({
    FormzSubmissionStatus? status,
    List<SearchDataModel>? searchedGifs,
    int? offset,
    String? errorMessage,
  }) {
    return SearchBlocState(
      status: status ?? this.status,
      searchedGifs: searchedGifs ?? this.searchedGifs,
      offset: offset ?? this.offset,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        status,
        searchedGifs,
        offset,
        errorMessage,
      ];
}
