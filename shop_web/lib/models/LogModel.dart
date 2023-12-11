class LogModel {
  String? message;
  String? ip;
  String? route;
  String? date;
  int? id;

  LogModel({this.message, this.ip, this.route, this.date, this.id});

  LogModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    ip = json['ip'];
    route = json['route'];
    id = json['id'];
    date = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['ip'] = this.ip;
    data['route'] = this.route;
    data['date'] = this.date;
    data['id'] = this.id;

    return data;
  }
}
