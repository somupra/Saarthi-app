class SignupModel{

  final token;

  SignupModel(this.token);
  SignupModel.fromJson(Map<String, dynamic> json):
      token = json['key'];

  Map<String, dynamic> toJson()=>
      {
        'key': token
      };
}