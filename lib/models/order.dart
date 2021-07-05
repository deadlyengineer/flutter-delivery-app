class Order {
  String id;
  String deliveryId;
  String status;
  String fee;
  String currency;
  String trackingUrl;
  String dropOffEta;

  Order(
      {this.id,
      this.deliveryId,
      this.status,
      this.fee,
      this.currency,
      this.trackingUrl,
      this.dropOffEta});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryId = json['delivery_id'];
    status = json['status'];
    fee = json['fee'];
    currency = json['currency'];
    trackingUrl = json['tracking_url'];
    dropOffEta = json['dropoff_eta'];
  }
}
