class GetSubscribedChannelListModel {
  String? message;
  List<SubscriptionsListData>? data;

  GetSubscribedChannelListModel({this.message, this.data});

  GetSubscribedChannelListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <SubscriptionsListData>[];
      json['data'].forEach((v) {
        data!.add(new SubscriptionsListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscriptionsListData {
  int? channelId;
  String? channelName;
  String? channelLogo;
  String? channelBanner;
  int? subscriberCount;
  String? description;
  String? createdAt;

  SubscriptionsListData(
      {this.channelId,
        this.channelName,
        this.channelLogo,
        this.channelBanner,
        this.subscriberCount,
        this.description,
        this.createdAt});

  SubscriptionsListData.fromJson(Map<String, dynamic> json) {
    channelId = json['channel_id'];
    channelName = json['channel_name'];
    channelLogo = json['channel_logo'];
    channelBanner = json['channel_banner'];
    subscriberCount = json['subscriber_count'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channel_id'] = this.channelId;
    data['channel_name'] = this.channelName;
    data['channel_logo'] = this.channelLogo;
    data['channel_banner'] = this.channelBanner;
    data['subscriber_count'] = this.subscriberCount;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}
