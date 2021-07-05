class CreditCard {
  String id;
  String cardBrand;
  int expMonth;
  int expYear;
  String last4;

  CreditCard({this.id, this.cardBrand, this.expMonth, this.expYear, this.last4});

  CreditCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardBrand = json['cardBrand'];
    expMonth = json['expMonth'];
    expYear = json['expYear'];
    last4 = json['last4'];
  }
}
