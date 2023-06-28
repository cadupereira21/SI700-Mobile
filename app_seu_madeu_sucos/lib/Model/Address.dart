class Address {
  String? _street;
  int? _streetNumber;
  String? _neighbour;
  String? _district;
  String? _city;
  String? _cep;

  Address({
    street = "",
    streetNumber = 0,
    neighbour = "",
    district = "AC",
    city = "",
    cep = ""
  });

  //create getters and setters
  String get getStreet => _street ?? "";
  set setStreet(String street) => _street = street;
  int get getStreetNumber => _streetNumber ?? 0;
  set setStreetNumber(int streetNumber) => _streetNumber = streetNumber;
  String get getNeighbour => _neighbour ?? "";
  set setNeighbour(String neighbour) => _neighbour = neighbour;
  String get getDistrict => _district ?? "";
  set setDistrict(String district) => _district = district;
  String get getCity => _city ?? "";
  set setCity(String city) => _city = city;
  String get getCep => _cep ?? "";
  set setCep(String cep) => _cep = cep;

  //create to string
  @override
  String toString() {
    return "Address: {street: $_street, streetNumber: $_streetNumber, neighbour: $_neighbour, district: $_district, city: $_city, cep: $_cep}";
  }
}
