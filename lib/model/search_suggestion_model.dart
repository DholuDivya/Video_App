class SearchSuggestionModel {
  String? status;
  String? message;
  List<Data>? data;

  SearchSuggestionModel({this.status, this.message, this.data});

  SearchSuggestionModel.fromJson(Map<String, dynamic> json) {
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
  String? keyword;
  int? frequency;

  Data({this.keyword, this.frequency});

  Data.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
    frequency = json['frequency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyword'] = this.keyword;
    data['frequency'] = this.frequency;
    return data;
  }
}
