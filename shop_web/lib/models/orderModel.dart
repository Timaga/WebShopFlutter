class OrderModel {
  int? customer_id;
  int? id;
  int? product_id;

  OrderModel({this.customer_id, this.id, this.product_id});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer_id = json['customer_id'];
    product_id = json['product_id'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customer_id;
    data['product_id'] = this.product_id;
    data['id'] = this.id;
    return data;
  }
}
