class OrderDetails {
  final int mealId;
  final String mealName;
 // final double price;
  final int qty;
  final String image;
 // final int flag;

  OrderDetails({
    required this.mealId,
    required this.mealName,
  //  required this.price,
    required this.qty,
    required this.image,
  //  this.flag = 1,
  });

  Map<String, dynamic> toJson() => {
    'meal_id': mealId,
    //'price': price,
    'qty': qty,
    //'flage': flag,
  };
}

class OrderModel {
  final double totalPrice;
  final String status;
  final List<Map<String, dynamic>> orderDetails;

  OrderModel({
    required this.totalPrice,
    required this.status,
    required this.orderDetails,
  });

  Map<String, dynamic> toJson() => {
    'total_price': totalPrice,
    'status': status,
    'order_details': orderDetails,
  };
}