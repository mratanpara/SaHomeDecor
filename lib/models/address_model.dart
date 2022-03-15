class AddressModel {
  AddressModel({
    required this.fullName,
    required this.phone,
    required this.address,
    required this.state,
    required this.zipcode,
    required this.city,
    required this.country,
    required this.isPrimary,
  });

  final String fullName;
  final int phone;
  final String address;
  final int zipcode;
  final String city;
  final String state;
  final String country;
  final bool isPrimary;
}
