class SettingsApiModel {
  bool? error;
  String? message;
  Data? data;

  SettingsApiModel({this.error, this.message, this.data});

  SettingsApiModel.fromJson(Map<String, dynamic> json) {
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
  String? currencySymbol;
  String? iosVersion;
  String? defaultLanguage;
  String? forceUpdate;
  String? androidVersion;
  String? numberWithSuffix;
  String? maintenanceMode;
  String? privacyPolicy;
  String? termsConditions;
  String? aboutUs;
  String? companyTel1;
  String? systemVersion;
  String? companyEmail;
  String? companyName;
  String? companyLogo;
  String? faviconIcon;
  String? loginImage;
  String? appStoreLink;
  String? playStoreLink;
  String? webThemeColor;
  String? firebaseProjectId;
  String? companyAddress;
  String? placeholderImage;
  String? webLogo;
  String? companyTel2;
  String? gecodeXyzApiKey;
  String? footerDescription;
  String? googleMapIframeLink;
  String? instagramLink;
  String? xLink;
  String? facebookLink;
  String? linkedinLink;
  String? pinterestLink;
  String? autoplay;
  String? downloadVideo;
  String? videoApprovalSystem;
  String? movieSystem;
  String? requireLoginToWatch;
  String? geoBlocking;
  String? shortsSystem;
  String? hashtagSystem;
  String? paidVideo;
  String? shortsDuration;
  String? maxVideoDuration;
  String? maxTitle;
  String? maxDescription;
  String? serviceFile;
  String? fcmKey;
  String? smtpUser;
  String? smtpPassword;
  String? smtpPort;
  String? smtpEncryption;
  String? host;

  Data(
      {this.currencySymbol,
        this.iosVersion,
        this.defaultLanguage,
        this.forceUpdate,
        this.androidVersion,
        this.numberWithSuffix,
        this.maintenanceMode,
        this.privacyPolicy,
        this.termsConditions,
        this.aboutUs,
        this.companyTel1,
        this.systemVersion,
        this.companyEmail,
        this.companyName,
        this.companyLogo,
        this.faviconIcon,
        this.loginImage,
        this.appStoreLink,
        this.playStoreLink,
        this.webThemeColor,
        this.firebaseProjectId,
        this.companyAddress,
        this.placeholderImage,
        this.webLogo,
        this.companyTel2,
        this.gecodeXyzApiKey,
        this.footerDescription,
        this.googleMapIframeLink,
        this.instagramLink,
        this.xLink,
        this.facebookLink,
        this.linkedinLink,
        this.pinterestLink,
        this.autoplay,
        this.downloadVideo,
        this.videoApprovalSystem,
        this.movieSystem,
        this.requireLoginToWatch,
        this.geoBlocking,
        this.shortsSystem,
        this.hashtagSystem,
        this.paidVideo,
        this.shortsDuration,
        this.maxVideoDuration,
        this.maxTitle,
        this.maxDescription,
        this.serviceFile,
        this.fcmKey,
        this.smtpUser,
        this.smtpPassword,
        this.smtpPort,
        this.smtpEncryption,
        this.host});

  Data.fromJson(Map<String, dynamic> json) {
    currencySymbol = json['currency_symbol'];
    iosVersion = json['ios_version'];
    defaultLanguage = json['default_language'];
    forceUpdate = json['force_update'];
    androidVersion = json['android_version'];
    numberWithSuffix = json['number_with_suffix'];
    maintenanceMode = json['maintenance_mode'];
    privacyPolicy = json['privacy_policy'];
    termsConditions = json['terms_conditions'];
    aboutUs = json['about_us'];
    companyTel1 = json['company_tel1'];
    systemVersion = json['system_version'];
    companyEmail = json['company_email'];
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    faviconIcon = json['favicon_icon'];
    loginImage = json['login_image'];
    appStoreLink = json['app_store_link'];
    playStoreLink = json['play_store_link'];
    webThemeColor = json['web_theme_color'];
    firebaseProjectId = json['firebase_project_id'];
    companyAddress = json['company_address'];
    placeholderImage = json['placeholder_image'];
    webLogo = json['web_logo'];
    companyTel2 = json['company_tel2'];
    gecodeXyzApiKey = json['gecode_xyz_api_key'];
    footerDescription = json['footer_description'];
    googleMapIframeLink = json['google_map_iframe_link'];
    instagramLink = json['instagram_link'];
    xLink = json['x_link'];
    facebookLink = json['facebook_link'];
    linkedinLink = json['linkedin_link'];
    pinterestLink = json['pinterest_link'];
    autoplay = json['autoplay'];
    downloadVideo = json['download_video'];
    videoApprovalSystem = json['video_approval_system'];
    movieSystem = json['movie_system'];
    requireLoginToWatch = json['require_login_to_watch'];
    geoBlocking = json['geo_blocking'];
    shortsSystem = json['shorts_system'];
    hashtagSystem = json['hashtag_system'];
    paidVideo = json['paid_video'];
    shortsDuration = json['shorts_duration'];
    maxVideoDuration = json['max_video_duration'];
    maxTitle = json['max_title'];
    maxDescription = json['max_description'];
    serviceFile = json['service_file'];
    fcmKey = json['fcm_key'];
    smtpUser = json['smtp_user'];
    smtpPassword = json['smtp_password'];
    smtpPort = json['smtp_port'];
    smtpEncryption = json['smtp_encryption'];
    host = json['host'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_symbol'] = this.currencySymbol;
    data['ios_version'] = this.iosVersion;
    data['default_language'] = this.defaultLanguage;
    data['force_update'] = this.forceUpdate;
    data['android_version'] = this.androidVersion;
    data['number_with_suffix'] = this.numberWithSuffix;
    data['maintenance_mode'] = this.maintenanceMode;
    data['privacy_policy'] = this.privacyPolicy;
    data['terms_conditions'] = this.termsConditions;
    data['about_us'] = this.aboutUs;
    data['company_tel1'] = this.companyTel1;
    data['system_version'] = this.systemVersion;
    data['company_email'] = this.companyEmail;
    data['company_name'] = this.companyName;
    data['company_logo'] = this.companyLogo;
    data['favicon_icon'] = this.faviconIcon;
    data['login_image'] = this.loginImage;
    data['app_store_link'] = this.appStoreLink;
    data['play_store_link'] = this.playStoreLink;
    data['web_theme_color'] = this.webThemeColor;
    data['firebase_project_id'] = this.firebaseProjectId;
    data['company_address'] = this.companyAddress;
    data['placeholder_image'] = this.placeholderImage;
    data['web_logo'] = this.webLogo;
    data['company_tel2'] = this.companyTel2;
    data['gecode_xyz_api_key'] = this.gecodeXyzApiKey;
    data['footer_description'] = this.footerDescription;
    data['google_map_iframe_link'] = this.googleMapIframeLink;
    data['instagram_link'] = this.instagramLink;
    data['x_link'] = this.xLink;
    data['facebook_link'] = this.facebookLink;
    data['linkedin_link'] = this.linkedinLink;
    data['pinterest_link'] = this.pinterestLink;
    data['autoplay'] = this.autoplay;
    data['download_video'] = this.downloadVideo;
    data['video_approval_system'] = this.videoApprovalSystem;
    data['movie_system'] = this.movieSystem;
    data['require_login_to_watch'] = this.requireLoginToWatch;
    data['geo_blocking'] = this.geoBlocking;
    data['shorts_system'] = this.shortsSystem;
    data['hashtag_system'] = this.hashtagSystem;
    data['paid_video'] = this.paidVideo;
    data['shorts_duration'] = this.shortsDuration;
    data['max_video_duration'] = this.maxVideoDuration;
    data['max_title'] = this.maxTitle;
    data['max_description'] = this.maxDescription;
    data['service_file'] = this.serviceFile;
    data['fcm_key'] = this.fcmKey;
    data['smtp_user'] = this.smtpUser;
    data['smtp_password'] = this.smtpPassword;
    data['smtp_port'] = this.smtpPort;
    data['smtp_encryption'] = this.smtpEncryption;
    data['host'] = this.host;
    return data;
  }
}
