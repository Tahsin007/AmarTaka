import 'package:amar_taka/core/error/failure.dart';
import 'package:amar_taka/features/category/data/datasources/category_remote_datasources.dart';
import 'package:amar_taka/features/category/data/model/category_model.dart';
import 'package:amar_taka/features/category/domain/entity/category_entity.dart';
import 'package:amar_taka/features/category/domain/repository/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  final CategoryRemoteDatasources categoryRemoteDataSources;
  CategoryRepositoryImpl(this.categoryRemoteDataSources);

  @override
  Future<Either<Failure, void>> addCategory(CategoryEntity categoryData) async {
    try{
      var categoryModel = CategoryModel.fromEntity(categoryData);
      await categoryRemoteDataSources.addCategory(categoryModel);
      return Right(null);
    } catch (e) {
      return Left(Failure( e.toString()));
    }
  }

  @override

  Future<Either<Failure, void>> deleteCategory(int categoryId)async {
    try{
      await categoryRemoteDataSources.deleteCategory(categoryId);
      return Right(null);
    }catch(e){
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure,List<CategoryEntity>>> getCategories() async{
    try{
      final response = await categoryRemoteDataSources.getCategories();
      return Right(response);
    }catch(e){
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure,void>> updateCategory(String categoryId, CategoryEntity updatedData) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

}