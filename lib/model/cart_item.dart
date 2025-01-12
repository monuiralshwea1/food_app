class CartItem {
  final int details_id;
  final String mealName;
  final double price;
  int quantity;
  final String image;

  CartItem({
    required this.details_id,
    required this.mealName,
    required this.price,
    this.quantity = 1,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'details_id': details_id,
      'mealName': mealName,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      details_id: json['details_id'] as int,
      mealName: json['mealName'] as String,
      price: json['price'].toDouble(),
      quantity: json['quantity'] as int,
      image: json['image'] as String,
    );
  }

  // For API calls
  Map<String, dynamic> toApiJson() {
    return {
      'details_id': details_id,
      'price': price,
      'qty': quantity,
      'flage': 1,
    };
  }

  double get totalPrice => price * quantity;
}
