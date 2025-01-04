class Meal {
  int? id;
  String name;
  String? description;
  int price;
  String? image;


  Meal(
      {
        this.id,
        required this.name,
        this.description,
        required this.price,
        this.image,
      });


  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: int.parse(json['id'].toString()), // Handle potential string IDs
      name: json['name'] as String,
      image: json['image'] as String?,
      price:  int.parse(json['price'].toString()),
      description: json['description'] as String?,
    );
  }

}


