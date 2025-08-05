import 'package:amar_taka/features/auth/domain/usecases/logout.dart';
import 'package:amar_taka/features/category/domain/entity/category_entity.dart';
import 'package:amar_taka/features/category/domain/usecases/add_category.dart';
import 'package:amar_taka/features/category/domain/usecases/get_categories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final AddCategoryUseCase _addCategoryUseCase;

  CategoriesBloc({
    required GetCategoriesUseCase getCategoriesUseCase,
    required AddCategoryUseCase addCategoryUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        _addCategoryUseCase = addCategoryUseCase,
        super(CategoriesInitial()) {
    on<GetAllCategoriesEvent>(_onGetAllCategories);
    on<AddCategoryEvent>(_onAddCategory);
  }

  void _onGetAllCategories(GetAllCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());
    final res = await _getCategoriesUseCase(NoParams());
    print("GetCategroesi Use case is called from here and response is : $res");
    res.fold(
      (failure) => emit(CategoriesError(failure.message)),
      (categories) => emit(CategoriesLoaded(categories)),
    );
  }

  void _onAddCategory(AddCategoryEvent event, Emitter<CategoriesState> emit) async {
    final res = await _addCategoryUseCase(CategoryEntity(name: event.name,type: event.type));
    print("From Add category Event Use case, Response is : $res");
    res.fold(
      (failure) => emit(CategoriesError(failure.message)),
      (_) => add(GetAllCategoriesEvent()),
    );
  }
}
