class PlansModel {
  bool? error;
  String? message;
  Data? data;

  PlansModel({this.error, this.message, this.data});

  PlansModel.fromJson(Map<String, dynamic> json) {
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
  List<Plans>? plans;
  String? activePlanName;

  Data({this.plans, this.activePlanName});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['plans'] != null) {
      plans = <Plans>[];
      json['plans'].forEach((v) {
        plans!.add(new Plans.fromJson(v));
      });
    }
    activePlanName = json['active_plan_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.plans != null) {
      data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    data['active_plan_name'] = this.activePlanName;
    return data;
  }
}

class Plans {
  int? id;
  String? name;
  String? price;
  Null? description;
  List<String>? features;
  String? createdAt;
  String? updatedAt;
  String? timePeriod;
  int? status;
  bool? isActive;

  Plans(
      {this.id,
        this.name,
        this.price,
        this.description,
        this.features,
        this.createdAt,
        this.updatedAt,
        this.timePeriod,
        this.status,
        this.isActive});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    features = json['features'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    timePeriod = json['timePeriod'];
    status = json['status'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['features'] = this.features;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['timePeriod'] = this.timePeriod;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    return data;
  }
}
