import 'dart:convert';

import 'package:amar_taka/core/constants/app_constants.dart';
import 'package:amar_taka/features/auth/data/datasources/remote_datasources.dart';
import 'package:amar_taka/features/category/data/model/category_model.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRemoteDatasources {
  Future<void> addCategory(CategoryModel categoryData);

  Future<List<CategoryModel>> getCategories();

  Future<void> updateCategory(String categoryId, CategoryModel updatedData);

  Future<void> deleteCategory(int categoryId);
}

class CategoryRemoteDatasourcesImpl implements CategoryRemoteDatasources {
  final http.Client client;
  final AuthRemoteDataSources authRemoteDataSources;

  CategoryRemoteDatasourcesImpl(this.client, this.authRemoteDataSources);

  @override
  Future<void> addCategory(CategoryModel categoryData) async {
    print("Category data request : $categoryData");
    print("Request Json Encoded : ${jsonEncode(categoryData.toJson())}");
    final url = Uri.parse(
      "${AppConstants.apiBaseUrl}/categories",
    ); // Replace with your API endpoint
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await authRemoteDataSources.getToken()}',
        },
        body: jsonEncode(categoryData.toJson()),
      );
      print("Raw add category data : ${response.body}");
      if (response.statusCode == 201) {
        print('Category added successfully');
      } else {
        print('Failed to add category: ${response.statusCode}');
        throw Exception('Failed to add category: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to add category: $e');
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final url = Uri.parse(
        "${AppConstants.apiBaseUrl}/categories",
      ); // Replace with your API endpoint
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await authRemoteDataSources.getToken()}',
        },
      );
      print("Raw body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<CategoryModel> data = jsonData
            .map((item) => CategoryModel.fromJson(item))
            .toList();
        print("Get Category Response Code : ${response.statusCode} ");
        print("Category Data : $data");
        return data;
      } else {
        print('Failed to fetch categories: ${response.statusCode}');
        throw Exception('Failed to fetch categories: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  @override
  Future<void> updateCategory(String categoryId, CategoryModel updatedData) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory(int categoryId) async {
    print("CategoryId from the api calling page: $categoryId");
    final url = Uri.parse('${AppConstants.apiBaseUrl}/categories/$categoryId');
    try {
      final response = await client.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${await authRemoteDataSources.getToken()}',
        },
      );
      print("Response from the api calling : ${response.body}");

      if (response.statusCode == 200) {
        return;
      } else {
        print("Delete api status code : ${response.statusCode}");
        throw Exception('Failed to delete categories: ${response.body}');
      }
    } catch (e) {
      print("From Delete Category : ${e.toString()}");
      throw Exception('Failed to delete categories: ${e.toString()}');
    }
  }
}
