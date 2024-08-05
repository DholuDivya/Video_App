class VideoCategoriesModel {
  String? message;
  List<Category>? categories;

  VideoCategoriesModel({this.message, this.categories});

  VideoCategoriesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  int? parentId;
  String? description;
  String? image;
  String? type;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.parentId,
    this.description,
    this.image,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    description = json['description'];
    image = json['image'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parent_id'] = parentId;
    data['description'] = description;
    data['image'] = image;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
