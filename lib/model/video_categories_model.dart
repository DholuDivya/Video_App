import 'dart:ui';

class VideoCategoriesModel {
  int? id;
  String? name;
  int? parentId;
  String? description;
  // Image? image;
  // Null? type;
  // String? createdAt;
  // String? updatedAt;

  VideoCategoriesModel(
      {this.id,
        this.name,
        this.parentId,
        this.description,
        // this.image,
        // this.type,
        // this.createdAt,
        // this.updatedAt
      });

  VideoCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    description = json['description'];
    // image = json['image'];
    // type = json['type'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['description'] = this.description;
    // data['image'] = this.image;
    // data['type'] = this.type;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}