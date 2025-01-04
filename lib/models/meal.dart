class Meal {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.description = '',
  });
}
