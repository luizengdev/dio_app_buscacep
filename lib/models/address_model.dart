class AddressBack4AppModel {
  List<Address> results = [];

  AddressBack4AppModel(this.results);

  AddressBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Address>[];
      json['results'].forEach((v) {
        results.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();

    return data;
  }
}

class Address {
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? cep;
  String? state;
  String? city;
  String? neighborhood;
  String? street;

  Address(
      {this.objectId,
      this.createdAt,
      this.updatedAt,
      this.cep,
      this.state,
      this.city,
      this.neighborhood,
      this.street});

  Address.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cep = json['cep'];
    state = json['state'];
    city = json['city'];
    neighborhood = json['neighborhood'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['cep'] = cep;
    data['state'] = state;
    data['city'] = city;
    data['neighborhood'] = neighborhood;
    data['street'] = street;

    return data;
  }

  Map<String, dynamic> toJsonBack4App() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['state'] = state;
    data['city'] = city;
    data['neighborhood'] = neighborhood;
    data['street'] = street;

    return data;
  }
}
