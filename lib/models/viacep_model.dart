import 'package:dio_app_buscacep/models/address_model.dart';

class ViaCepModel {
  String? cep;
  String? logradouro;
  String? bairro;
  String? localidade;
  String? uf;

  ViaCepModel({
    this.cep,
    this.logradouro,
    this.bairro,
    this.localidade,
    this.uf,
  });

  ViaCepModel.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;

    return data;
  }

  Address toAddress() {
    return Address(
      cep: cep,
      state: uf,
      city: localidade,
      neighborhood: bairro,
      street: logradouro,
    );
  }
}
