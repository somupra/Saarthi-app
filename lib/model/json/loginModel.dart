class LoginModel {
  final String username;
  final String first_name;
  final String last_name;
  final String email;
  final int userId;

  LoginModel(this.username, this.first_name, this.last_name, this.email, this.userId);

  LoginModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        first_name = json['first_name'],
        last_name = json['last_name'],
        email = json['email'],
        userId = json['pk'];

  Map<String, dynamic> toJson() =>
      {
        'pk': userId,
        'username': username,
        'email': email,
        'first_name': first_name,
        'last_name': last_name,
      };
}