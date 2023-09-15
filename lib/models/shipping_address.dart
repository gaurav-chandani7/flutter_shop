class ShippingAddress {
  String name;
  num? mobile;
  num? pincode;
  String state;
  String address;
  String town;
  String? typeOfAddress;
  ShippingAddress({
    required this.name,
    this.mobile,
    this.pincode,
    required this.state,
    required this.address,
    required this.town,
    this.typeOfAddress,
  });

  ShippingAddress.initial(
      {this.name = "", this.state = "", this.address = "", this.town = ""});
}
