class SearchSuggestionModel {
  bool? error;
  String? message;
  Data? data;

  SearchSuggestionModel({this.error, this.message, this.data});

  SearchSuggestionModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? videoSuggestions;
  List<String>? channelSuggestions;

  Data({this.videoSuggestions, this.channelSuggestions});

  Data.fromJson(Map<String, dynamic> json) {
    videoSuggestions = json['video_suggestions'].cast<String>();
    channelSuggestions = json['channel_suggestions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_suggestions'] = this.videoSuggestions;
    data['channel_suggestions'] = this.channelSuggestions;
    return data;
  }
}
