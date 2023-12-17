class AuthModel {
  String? login;
  String? password;
  int? id;

  AuthModel({ this.id,this.login,this.password});

  AuthModel.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    password = json['password'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['password'] = this.password;
    data['id'] = this.id;
    return data;
  }
}
