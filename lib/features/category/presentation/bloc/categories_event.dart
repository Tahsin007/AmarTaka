part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetAllCategoriesEvent extends CategoriesEvent {}

class AddCategoryEvent extends CategoriesEvent {
  final String name;
  final String type;

  const AddCategoryEvent({required this.name,required this.type});

  @override
  List<Object> get props => [name];
}

class DeleteCategoryEvent extends CategoriesEvent{
  final int id;
  const DeleteCategoryEvent({required this.id});
}


