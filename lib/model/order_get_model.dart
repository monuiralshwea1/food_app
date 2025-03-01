class OrderModelGet {
  int? id;
  int? branchId;
  int? customerId;
  String? dateTime;
  String? status;
  String? totalPrice;
  String? createdAt;
  String? updatedAt;

  OrderModelGet(
      {this.id,
        this.branchId,
        this.customerId,
        this.dateTime,
        this.status,
        this.totalPrice,
        this.createdAt,
        this.updatedAt});

  OrderModelGet.fromJson(Map<String, dynamic> json) {
    id =  int.parse(json['id'].toString());
    dateTime = json['dateTime'];
    status = json['status'];
    totalPrice = json['total_price'];

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id?.toString(), // تحويل id إلى String لتجنب أي مشاكل
      'dateTime': dateTime,
      'status': status,
      'totalPrice': totalPrice,
    };
  }


}
