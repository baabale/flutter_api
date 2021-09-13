class User {
  late int id;
  late String name, username, email;

  // factory method / contructor
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
  }
}
