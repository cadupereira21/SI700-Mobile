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

  //create getters and setters
  String? get getStreet => street;
  set setStreet(String? street) => this.street = street;
  int? get getStreetNumber => streetNumber;
  set setStreetNumber(int? streetNumber) => this.streetNumber = streetNumber;
  String? get getNeighbour => neighbour;
  set setNeighbour(String? neighbour) => this.neighbour = neighbour;
  String? get getDistrict => district;
  set setDistrict(String? district) => this.district = district;
  String? get getCity => city;
  set setCity(String? city) => this.city = city;
  String? get getCep => cep;

  //create to string
  @override
  String toString() {
    return "Address: {street: $street, streetNumber: $streetNumber, neighbour: $neighbour, district: $district, city: $city, cep: $cep}";
  }
}
