class SearchDataModel {
  bool? error;
  String? message;
  Data? data;

  SearchDataModel({this.error, this.message, this.data});

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Videos>? videos;
  List<Channels>? channels;

  Data({this.videos, this.channels});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    if (json['channels'] != null) {
      channels = <Channels>[];
      json['channels'].forEach((v) {
        channels!.add(new Channels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    if (this.channels != null) {
      data['channels'] = this.channels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
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

  Videos(
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

  Videos.fromJson(Map<String, dynamic> json) {
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
  Null? banner;
  Null? subscriberCount;

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
  String? url;

  Categories({this.id, this.name, this.url});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Channels {
  int? id;
  String? name;
  String? description;
  String? logo;
  String? banner;
  String? url;
  List<Videos>? videos;

  Channels(
      {this.id,
        this.name,
        this.description,
        this.logo,
        this.banner,
        this.url,
        this.videos});

  Channels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
    banner = json['banner'];
    url = json['url'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['logo'] = this.logo;
    data['banner'] = this.banner;
    data['url'] = this.url;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoData {
  int? id;
  String? title;
  String? url;

  VideoData({this.id, this.title, this.url});

  VideoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}
