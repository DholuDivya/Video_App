// class GetShortsListModel {
//   String? status;
//   String? message;
//   ShortsData? data;
//
//   GetShortsListModel({this.status, this.message, this.data});
//
//   GetShortsListModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new ShortsData.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class ShortsData {
//   int? currentPage;
//   List<Data>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Links>? links;
//   Null? nextPageUrl;
//   String? path;
//   int? perPage;
//   Null? prevPageUrl;
//   int? to;
//   int? total;
//
//   ShortsData(
//       {this.currentPage,
//         this.data,
//         this.firstPageUrl,
//         this.from,
//         this.lastPage,
//         this.lastPageUrl,
//         this.links,
//         this.nextPageUrl,
//         this.path,
//         this.perPage,
//         this.prevPageUrl,
//         this.to,
//         this.total});
//
//   ShortsData.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     if (json['links'] != null) {
//       links = <Links>[];
//       json['links'].forEach((v) {
//         links!.add(new Links.fromJson(v));
//       });
//     }
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['first_page_url'] = this.firstPageUrl;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     data['last_page_url'] = this.lastPageUrl;
//     if (this.links != null) {
//       data['links'] = this.links!.map((v) => v.toJson()).toList();
//     }
//     data['next_page_url'] = this.nextPageUrl;
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['prev_page_url'] = this.prevPageUrl;
//     data['to'] = this.to;
//     data['total'] = this.total;
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
//   int? comments;
//   String? uploadedBy;
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
//         this.comments,
//         this.uploadedBy,
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
//     comments = json['comments'];
//     uploadedBy = json['uploaded_by'];
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
//     data['comments'] = this.comments;
//     data['uploaded_by'] = this.uploadedBy;
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
//   Null? banner;
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
//   Null? parentId;
//   Null? description;
//   Null? image;
//   Null? type;
//   String? createdAt;
//   String? updatedAt;
//   Pivot? pivot;
//
//   Categories(
//       {this.id,
//         this.name,
//         this.parentId,
//         this.description,
//         this.image,
//         this.type,
//         this.createdAt,
//         this.updatedAt,
//         this.pivot});
//
//   Categories.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     parentId = json['parent_id'];
//     description = json['description'];
//     image = json['image'];
//     type = json['type'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
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
//     data['type'] = this.type;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
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
//
// class Links {
//   String? url;
//   String? label;
//   bool? active;
//
//   Links({this.url, this.label, this.active});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     label = json['label'];
//     active = json['active'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['label'] = this.label;
//     data['active'] = this.active;
//     return data;
//   }
// }















class GetShortsListModel {
  String? status;
  String? message;
  List<Data>? data;

  GetShortsListModel({this.status, this.message, this.data});

  GetShortsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    data['status'] = this.status;
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
  bool? isLiked;
  bool? isDisliked;
  int? comments;

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
        this.createdAtHuman,
        this.isLiked,
        this.isDisliked,
        this.comments});

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
    isLiked = json['is_liked'];
    isDisliked = json['is_disliked'];
    comments = json['comments'];
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
    data['is_liked'] = this.isLiked;
    data['is_disliked'] = this.isDisliked;
    data['comments'] = this.comments;
    return data;
  }
}

class Channel {
  int? id;
  String? name;
  String? logo;
  Null? banner;
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
  Null? parentId;
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
