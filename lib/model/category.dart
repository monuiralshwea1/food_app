class Category {
  int? id;
  String name;
  String? image;
  String? description;

  Category({this.id, required this.name, this.image, this.description});



  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: int.parse(json['id'].toString()), // Handle potential string IDs
      name: json['name'] as String,
      image: json['image'] as String?,
      description: json['description'] as String?,
    );
  }
}