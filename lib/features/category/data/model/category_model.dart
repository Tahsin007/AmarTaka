import 'package:amar_taka/features/category/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({ int? id,required  String name,required  String type})
    : super(id: id, name: name, type: type);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id :json['id'] as int,
      name : json['name'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'type': type};
  }

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(name: entity.name,type: entity.type);
  }
}
