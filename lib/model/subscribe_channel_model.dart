class SubscribeChannelModel {
  String? message;
  int? subscriberCount;
  bool? isSubscribed;

  SubscribeChannelModel({this.message, this.subscriberCount, this.isSubscribed});

  SubscribeChannelModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    subscriberCount = json['subscriber_count'];
    isSubscribed = json['is_subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['subscriber_count'] = this.subscriberCount;
    data['is_subscribed'] = this.isSubscribed;
    return data;
  }
}
