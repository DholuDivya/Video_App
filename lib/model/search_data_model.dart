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
  List<RelatedVideos>? relatedVideos;
  List<Channels>? channels;

  Data({this.videos, this.relatedVideos, this.channels});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    if (json['related_videos'] != null) {
      relatedVideos = <RelatedVideos>[];
      json['related_videos'].forEach((v) {
        relatedVideos!.add(new RelatedVideos.fromJson(v));
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
    if (this.relatedVideos != null) {
      data['related_videos'] =
          this.relatedVideos!.map((v) => v.toJson()).toList();
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
  int? duration;
  String? description;
  Channel? channel;
  String? hashtag;
  int? views;
  int? likes;
  String? type;
  String? video;
  String? thumbnail;
  String? createdAtHuman;

  Videos(
      {this.id,
        this.slug,
        this.title,
        this.duration,
        this.description,
        this.channel,
        this.hashtag,
        this.views,
        this.likes,
        this.type,
        this.video,
        this.thumbnail,
        this.createdAtHuman});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    duration = json['duration'];
    description = json['description'];
    channel =
    json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
    hashtag = json['hashtag'];
    views = json['views'];
    likes = json['likes'];
    type = json['type'];
    video = json['video'];
    thumbnail = json['thumbnail'];
    createdAtHuman = json['created_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['duration'] = this.duration;
    data['description'] = this.description;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    data['hashtag'] = this.hashtag;
    data['views'] = this.views;
    data['likes'] = this.likes;
    data['type'] = this.type;
    data['video'] = this.video;
    data['thumbnail'] = this.thumbnail;
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

class RelatedVideos {
  int? id;
  String? slug;
  String? title;
  String? description;
  String? hashtag;
  int? views;
  int? likes;
  String? type;
  String? video;
  String? thumbnail;

  RelatedVideos(
      {this.id,
        this.slug,
        this.title,
        this.description,
        this.hashtag,
        this.views,
        this.likes,
        this.type,
        this.video,
        this.thumbnail});

  RelatedVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    hashtag = json['hashtag'];
    views = json['views'];
    likes = json['likes'];
    type = json['type'];
    video = json['video'];
    thumbnail = json['thumbnail'];
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
    data['video'] = this.video;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class Channels {
  int? id;
  String? name;
  String? description;
  String? logo;
  String? banner;
  Null? subscribersCount;
  String? url;

  Channels(
      {this.id,
        this.name,
        this.description,
        this.logo,
        this.banner,
        this.subscribersCount,
        this.url});

  Channels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
    banner = json['banner'];
    subscribersCount = json['subscribers_count'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['logo'] = this.logo;
    data['banner'] = this.banner;
    data['subscribers_count'] = this.subscribersCount;
    data['url'] = this.url;
    return data;
  }
}
