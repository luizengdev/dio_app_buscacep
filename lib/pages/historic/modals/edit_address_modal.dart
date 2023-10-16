import 'package:dio_app_buscacep/models/address_model.dart';
import 'package:dio_app_buscacep/pages/home/home_controller.dart';
import 'package:dio_app_buscacep/repositories/back4app_cep_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAddressModal extends StatefulWidget {
  final Address address;

  const EditAddressModal({Key? key, required this.address}) : super(key: key);

  @override
  _EditAddressModalState createState() => _EditAddressModalState();
}

class _EditAddressModalState extends State<EditAddressModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var homeController = Get.put(HomeController());

  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cepController.text = widget.address.cep ?? '';
    _stateController.text = widget.address.state ?? '';
    _cityController.text = widget.address.city ?? '';
    _neighborhoodController.text = widget.address.neighborhood ?? '';
    _streetController.text = widget.address.street ?? '';

    _cepController.addListener(_handleFormEdited);
    _stateController.addListener(_handleFormEdited);
    _cityController.addListener(_handleFormEdited);
    _neighborhoodController.addListener(_handleFormEdited);
    _streetController.addListener(_handleFormEdited);
  }

  void _handleFormEdited() {
    if (!homeController.isFormUpdateCepEdited.value) {
      setState(() {
        homeController.isFormUpdateCepEdited.value = true;
      });
    }
  }

  // Método genérico para validação de campos de texto não vazios
  String? _validateNonEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'O campo $fieldName é obrigatório.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Endereço'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _cepController,
                decoration: const InputDecoration(labelText: 'CEP'),
                validator: (value) => _validateNonEmpty(value, 'CEP'),
              ),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(labelText: 'Estado'),
                validator: (value) => _validateNonEmpty(value, 'Estado'),
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'Cidade'),
                validator: (value) => _validateNonEmpty(value, 'Cidade'),
              ),
              TextFormField(
                controller: _neighborhoodController,
                decoration: const InputDecoration(labelText: 'Bairro'),
                validator: (value) => _validateNonEmpty(value, 'Bairro'),
              ),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(labelText: 'Rua'),
                validator: (value) => _validateNonEmpty(value, 'Rua'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: homeController.isFormUpdateCepEdited.value
              ? () async {
                  if (_formKey.currentState!.validate()) {
                    widget.address.cep = _cepController.text;
                    widget.address.state = _stateController.text;
                    widget.address.city = _cityController.text;
                    widget.address.neighborhood = _neighborhoodController.text;
                    widget.address.street = _streetController.text;

                    await Back4appCepRepository().updateCep(widget.address);

                    homeController.isFormUpdateCepEdited.value = false;

                    Navigator.of(context).pop();
                  }
                }
              : null,
          child: const Text(
            'Salvar',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }
}
