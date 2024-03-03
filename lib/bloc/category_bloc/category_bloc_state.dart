part of 'category_bloc.dart';

abstract class CategoryBlocState extends Equatable {
  const CategoryBlocState();
}

// intial state
class CategoryBlocInitialState extends CategoryBlocState {
  @override
  List<Object?> get props => [];
}

// loading state

class CategoryBlocLoadingState extends CategoryBlocState {
  @override
  List<Object?> get props => [];
}

// loaded state
class CategoryBlocLoadedState extends CategoryBlocState {
  final CategoryListModel categoryList;

  const CategoryBlocLoadedState({
    required this.categoryList,
  });
  @override
  List<Object?> get props => [
        categoryList,
      ];
}

// error state
class CategoryBlocErrorState extends CategoryBlocState {
  final String message;

  const CategoryBlocErrorState({
    required this.message,
  });
  @override
  List<Object?> get props => [
        message,
      ];
}
