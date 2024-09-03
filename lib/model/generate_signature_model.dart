class GenerateSignatureModel {
  String? status;
  String? orderId;
  String? keyId;
  String? signature;

  GenerateSignatureModel(
      {this.status, this.orderId, this.keyId, this.signature});

  GenerateSignatureModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    orderId = json['order_id'];
    keyId = json['key_id'];
    signature = json['signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['order_id'] = this.orderId;
    data['key_id'] = this.keyId;
    data['signature'] = this.signature;
    return data;
  }
}
