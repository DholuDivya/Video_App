class PlansModel {
  bool? error;
  String? message;
  List<Data>? data;

  PlansModel({this.error, this.message, this.data});

  PlansModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
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
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? price;
  List<String>? features;
  String? createdAt;
  String? updatedAt;
  String? timePeriod;
  int? status;

  Data(
      {this.id,
        this.name,
        this.price,
        this.features,
        this.createdAt,
        this.updatedAt,
        this.timePeriod,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    features = json['features'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    timePeriod = json['time_period'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['features'] = this.features;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['time_period'] = this.timePeriod;
    data['status'] = this.status;
    return data;
  }
}
