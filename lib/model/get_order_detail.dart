class GetOrderDetails {
  int? id;
  int? orderId;
  int? qty;
  String? price;
  int? total;
  String? createdAt;
  String? updatedAt;
  int? mealId;

  GetOrderDetails(
      {this.id,
        this.orderId,
        this.qty,
        this.price,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.mealId});

  GetOrderDetails.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    orderId = int.parse(json['orderId'].toString());
    qty = int.parse(json['qty'].toString());
    price = json['price'];
    total = json['total'];
    mealId = json['meal_id'];
  }


}



