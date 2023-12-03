class LogModel {
  String? message;
  String? ip;

  LogModel({this.message, this.ip});

  LogModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['ip'] = this.ip;
    return data;
  }
}