import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/features/category/domain/entity/category_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoryRepository {
  Future<Either<Failure,void>> addCategory(CategoryEntity categoryData);

  Future<Either<Failure,List<CategoryEntity>>> getCategories();

  Future<Either<Failure,void>> updateCategory(String categoryId, CategoryEntity updatedData);

  Future<Either<Failure,void>> deleteCategory(int categoryId);
}