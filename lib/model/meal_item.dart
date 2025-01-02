class MealItem {
  final int id;
  final String name;
  final String? description;

  MealItem({
    required this.id,
    required this.name,
    this.description,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      id: int.parse(json['id'].toString()), // Handle potential string IDs
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }
}