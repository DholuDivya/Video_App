class AppPrivacyContentModel {
  bool? error;
  String? message;
  Data? data;

  AppPrivacyContentModel({this.error, this.message, this.data});

  AppPrivacyContentModel.fromJson(Map<String, dynamic> json) {
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
  String? aboutUs;
  String? termsAndConditions;
  String? privacy;

  Data({this.aboutUs, this.termsAndConditions, this.privacy});

  Data.fromJson(Map<String, dynamic> json) {
    aboutUs = json['about_us'];
    termsAndConditions = json['terms_and_conditions'];
    privacy = json['privacy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about_us'] = this.aboutUs;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['privacy'] = this.privacy;
    return data;
  }
}
