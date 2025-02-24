class GetOrderDetails {
  int? mealId;
  String? mealName;
  String? image;
  String? price;
  int? qty;
  int? total;

  GetOrderDetails(
      {this.mealId,
        this.mealName,
        this.image,
        this.price,
        this.qty,
        this.total});

  GetOrderDetails.fromJson(Map<String, dynamic> json) {
    mealId = json['meal_id'];
    mealName = json['meal_name'];
    image = json['image'];
    price = json['price'];
    qty = json['qty'];
    total = json['total'];
  }


}