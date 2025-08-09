import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/usecases/usecase.dart';
import 'package:amar_taka/features/category/domain/repository/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteCategoryUseCase implements UseCase<void, int> {
  final CategoryRepository categoryRepository;
  DeleteCategoryUseCase(this.categoryRepository);
  @override
  Future<Either<Failure, void>> call(int id) {
    return categoryRepository.deleteCategory(id);
  }

}

class DeleteCategoryparams {
  int id;
  DeleteCategoryparams(this.id);
}