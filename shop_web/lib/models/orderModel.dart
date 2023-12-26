class OrderModel {
  int? customer_id;
  int? id;
  int? product_id;

  OrderModel({this.customer_id, this.id, this.product_id});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer_id = json['id_customer'];
    product_id = json['id_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_customer'] = this.customer_id;
    data['id_product'] = this.product_id;
    data['id'] = this.id;
    return data;
  }
}
