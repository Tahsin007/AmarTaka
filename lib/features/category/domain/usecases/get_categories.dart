import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/usecases/usecase.dart';
import 'package:amar_taka/features/category/domain/entity/category_entity.dart';
import 'package:amar_taka/features/category/domain/repository/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCategoriesUseCase implements UseCase<List<CategoryEntity>,NoParams>{
  final CategoryRepository categoryRepository;
  GetCategoriesUseCase(this.categoryRepository);
  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async {{
    return await categoryRepository.getCategories();
  }

}
}