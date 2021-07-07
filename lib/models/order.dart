class Order {
  String id;
  String deliveryId;
  String status;
  String fee;
  String currency;
  String trackingUrl;
  String dropOffEta;
  String pickUpAddress;
  String dropOffAddress;

  Order({
    this.id,
    this.deliveryId,
    this.status,
    this.fee,
    this.currency,
    this.trackingUrl,
    this.dropOffEta,
    this.pickUpAddress,
    this.dropOffAddress,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryId = json['delivery_id'];
    status = json['status'];
    fee = json['fee'];
    currency = json['currency'];
    trackingUrl = json['tracking_url'];
    dropOffEta = json['dropoff_eta'];
    pickUpAddress = json['pickup_address'];
    dropOffAddress = json['dropoff_address'];
  }
}
