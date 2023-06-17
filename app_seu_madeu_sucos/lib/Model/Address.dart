class Address {
  String? street;
  int? streetNumber;
  String? neighbour;
  String? district;
  String? city;
  String? cep;

  Address({
    this.street,
    this.streetNumber,
    this.neighbour,
    this.district,
    this.city,
    this.cep
  });

  //create to string
  @override
  String toString() {
    return "Address: {street: $street, streetNumber: $streetNumber, neighbour: $neighbour, district: $district, city: $city, cep: $cep}";
  }
}
