class Offer {
  final int id;
  final int meal_id;
  final String mealName;
  final String image;
  final double originalPrice;
  final double discountPercentage;
  final double discountedPrice;
  final DateTime startDate;
  final DateTime endDate;

  Offer({
    required this.id,
    required this.meal_id,
    required this.mealName,
    required this.image,
    required this.originalPrice,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.startDate,
    required this.endDate,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      meal_id: json['meal_id'],
      mealName: json['meal_name'],
      image: json['image'],
      originalPrice: double.parse(json['original_price']),
      discountPercentage: json['discount_percentage'].toDouble(),
      discountedPrice: double.parse(json['discounted_price']),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }
}

List<Offer> parseOffers(Map<String, dynamic> jsonResponse) {
  var offersJson = jsonResponse['all_offers'] as List;
  return offersJson.map((offer) => Offer.fromJson(offer)).toList();
}