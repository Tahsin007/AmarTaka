import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/core/usecases/usecase.dart';
import 'package:amar_taka/features/category/domain/entity/category_entity.dart';
import 'package:amar_taka/features/category/domain/repository/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddCategoryUseCase implements UseCase<void,CategoryEntity> {
  final CategoryRepository categoryRepository;
  AddCategoryUseCase(this.categoryRepository);
  @override
  Future<Either<Failure, void>> call(CategoryEntity params) async{
    return await categoryRepository.addCategory(params);
  }

}

