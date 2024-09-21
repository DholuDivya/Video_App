// class AllVideoListModel {
//   String? error;
//   String? message;
//   List<Data>? data;
//
//   AllVideoListModel({this.error, this.message, this.data});
//
//   AllVideoListModel.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['error'] = this.error;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? slug;
//   String? title;
//   String? description;
//   String? hashtag;
//   int? views;
//   int? likes;
//   String? type;
//   Channel? channel;
//   String? status;
//   String? visibility;
//   int? duration;
//   String? video;
//   String? thumbnail;
//   List<Categories>? categories;
//   String? createdAtHuman;
//
//   Data(
//       {this.id,
//         this.slug,
//         this.title,
//         this.description,
//         this.hashtag,
//         this.views,
//         this.likes,
//         this.type,
//         this.channel,
//         this.status,
//         this.visibility,
//         this.duration,
//         this.video,
//         this.thumbnail,
//         this.categories,
//         this.createdAtHuman});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     slug = json['slug'];
//     title = json['title'];
//     description = json['description'];
//     hashtag = json['hashtag'];
//     views = json['views'];
//     likes = json['likes'];
//     type = json['type'];
//     channel =
//     json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
//     status = json['status'];
//     visibility = json['visibility'];
//     duration = json['duration'];
//     video = json['video'];
//     thumbnail = json['thumbnail'];
//     if (json['categories'] != null) {
//       categories = <Categories>[];
//       json['categories'].forEach((v) {
//         categories!.add(new Categories.fromJson(v));
//       });
//     }
//     createdAtHuman = json['created_at_human'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['slug'] = this.slug;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['hashtag'] = this.hashtag;
//     data['views'] = this.views;
//     data['likes'] = this.likes;
//     data['type'] = this.type;
//     if (this.channel != null) {
//       data['channel'] = this.channel!.toJson();
//     }
//     data['status'] = this.status;
//     data['visibility'] = this.visibility;
//     data['duration'] = this.duration;
//     data['video'] = this.video;
//     data['thumbnail'] = this.thumbnail;
//     if (this.categories != null) {
//       data['categories'] = this.categories!.map((v) => v.toJson()).toList();
//     }
//     data['created_at_human'] = this.createdAtHuman;
//     return data;
//   }
// }
//
// class Channel {
//   int? id;
//   String? name;
//   String? logo;
//   String? banner;
//   int? subscriberCount;
//
//   Channel({this.id, this.name, this.logo, this.banner, this.subscriberCount});
//
//   Channel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     logo = json['logo'];
//     banner = json['banner'];
//     subscriberCount = json['subscriber_count'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['logo'] = this.logo;
//     data['banner'] = this.banner;
//     data['subscriber_count'] = this.subscriberCount;
//     return data;
//   }
// }
//
// class Categories {
//   int? id;
//   String? name;
//   String? parentId;
//   String? description;
//   String? image;
//   String? createdAt;
//   String? updatedAt;
//   int? status;
//   Pivot? pivot;
//
//   Categories(
//       {this.id,
//         this.name,
//         this.parentId,
//         this.description,
//         this.image,
//         this.createdAt,
//         this.updatedAt,
//         this.status,
//         this.pivot});
//
//   Categories.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     parentId = json['parent_id'];
//     description = json['description'];
//     image = json['image'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     status = json['status'];
//     pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['parent_id'] = this.parentId;
//     data['description'] = this.description;
//     data['image'] = this.image;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['status'] = this.status;
//     if (this.pivot != null) {
//       data['pivot'] = this.pivot!.toJson();
//     }
//     return data;
//   }
// }
//
// class Pivot {
//   int? videoId;
//   int? categoryId;
//
//   Pivot({this.videoId, this.categoryId});
//
//   Pivot.fromJson(Map<String, dynamic> json) {
//     videoId = json['video_id'];
//     categoryId = json['category_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['video_id'] = this.videoId;
//     data['category_id'] = this.categoryId;
//     return data;
//   }
// }

















class AllVideoListModel {
  String? error;
  String? message;
  List<Data>? data;

  AllVideoListModel({this.error, this.message, this.data});

  AllVideoListModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? slug;
  String? title;
  String? description;
  String? hashtag;
  int? views;
  int? likes;
  String? type;
  Channel? channel;
  String? status;
  String? visibility;
  int? duration;
  String? video;
  String? thumbnail;
  List<Categories>? categories;
  String? createdAtHuman;

  Data(
      {this.id,
        this.slug,
        this.title,
        this.description,
        this.hashtag,
        this.views,
        this.likes,
        this.type,
        this.channel,
        this.status,
        this.visibility,
        this.duration,
        this.video,
        this.thumbnail,
        this.categories,
        this.createdAtHuman});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    hashtag = json['hashtag'];
    views = json['views'];
    likes = json['likes'];
    type = json['type'];
    channel =
    json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
    status = json['status'];
    visibility = json['visibility'];
    duration = json['duration'];
    video = json['video'];
    thumbnail = json['thumbnail'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    createdAtHuman = json['created_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['description'] = this.description;
    data['hashtag'] = this.hashtag;
    data['views'] = this.views;
    data['likes'] = this.likes;
    data['type'] = this.type;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    data['status'] = this.status;
    data['visibility'] = this.visibility;
    data['duration'] = this.duration;
    data['video'] = this.video;
    data['thumbnail'] = this.thumbnail;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['created_at_human'] = this.createdAtHuman;
    return data;
  }
}

class Channel {
  int? id;
  String? name;
  String? logo;
  String? banner;
  int? subscriberCount;

  Channel({this.id, this.name, this.logo, this.banner, this.subscriberCount});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    banner = json['banner'];
    subscriberCount = json['subscriber_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['banner'] = this.banner;
    data['subscriber_count'] = this.subscriberCount;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  int? parentId;
  Null? description;
  Null? image;
  String? createdAt;
  String? updatedAt;
  int? status;
  Pivot? pivot;

  Categories(
      {this.id,
        this.name,
        this.parentId,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.pivot});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? videoId;
  int? categoryId;

  Pivot({this.videoId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_id'] = this.videoId;
    data['category_id'] = this.categoryId;
    return data;
  }
}
