class GetNotificationModel {
  String? error;
  String? message;
  Data? data;

  GetNotificationModel({this.error, this.message, this.data});

  GetNotificationModel.fromJson(Map<String, dynamic> json) {
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
  List<Today>? today;
  List<Today>? thisWeek;
  List<Today>? older;

  Data({this.today, this.thisWeek, this.older});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['today'] != null) {
      today = <Today>[];
      json['today'].forEach((v) {
        today!.add(new Today.fromJson(v));
      });
    }
    if (json['this_week'] != null) {
      thisWeek = <Today>[];
      json['this_week'].forEach((v) {
        thisWeek!.add(new Today.fromJson(v));
      });
    }
    if (json['older'] != null) {
      older = <Today>[];
      json['older'].forEach((v) {
        older!.add(new Today.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.today != null) {
      data['today'] = this.today!.map((v) => v.toJson()).toList();
    }
    if (this.thisWeek != null) {
      data['this_week'] = this.thisWeek!.map((v) => v.toJson()).toList();
    }
    if (this.older != null) {
      data['older'] = this.older!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Today {
  int? id;
  String? title;
  String? description;
  String? slug;
  String? thumbnail;
  String? createdAtHuman;
  Channel? channel;

  Today(
      {this.id,
        this.title,
        this.description,
        this.slug,
        this.thumbnail,
        this.createdAtHuman,
        this.channel});

  Today.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    slug = json['slug'];
    thumbnail = json['thumbnail'];
    createdAtHuman = json['created_at_human'];
    channel =
    json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['thumbnail'] = this.thumbnail;
    data['created_at_human'] = this.createdAtHuman;
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    return data;
  }
}

class Channel {
  int? id;
  String? name;
  String? logo;
  String? banner;

  Channel({this.id, this.name, this.logo, this.banner});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['banner'] = this.banner;
    return data;
  }
}
