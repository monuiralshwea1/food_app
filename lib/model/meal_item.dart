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

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(), // تحويل id إلى String لتجنب أي مشاكل
      'name': name,
      'description': description,
    };
  }
}