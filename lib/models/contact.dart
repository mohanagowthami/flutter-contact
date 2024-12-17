class Contact {
  int? id;
  String name;
  String mobile;
  String? landline;
  String? photoPath;
  bool isFavorite;

  Contact({
    this.id,
    required this.name,
    required this.mobile,
    required this.landline,
    required this.photoPath,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'landline': landline,
      'photoPath': photoPath,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  static Contact fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      mobile: map['mobile'],
      landline: map['landline'],
      photoPath: map['photoPath'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
