class User {
  int? id;
  String? username;
  String? password;
  String? imagePath; // Image path can be null

  User({
    this.id,
    required this.username,
    required this.password,
    this.imagePath, // Change this to make it optional
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        password: json['password'], //
        imagePath: json['imagePath'] ??
            'assets/image/default.png', // Ensure a default image is used if null
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "imagePath": imagePath, // Include imagePath in the JSON
      };
}
