part of 'category_bloc.dart';

abstract class CategoryBlocEvent extends Equatable {}

class FetchCategoryBlocEvent extends CategoryBlocEvent {
  FetchCategoryBlocEvent();

  @override
  List<Object?> get props => [];
}
