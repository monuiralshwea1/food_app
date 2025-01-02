class Category {
  int? id;
  String? name;
  String? image;
  String? description;

  Category({this.id, this.name, this.image, this.description});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }


  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: int.parse(json['id'].toString()), // Handle potential string IDs
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String?,
    );
  }
}