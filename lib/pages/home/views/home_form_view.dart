import 'package:dio_app_buscacep/repositories/consult_cep_repository.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomeFormView extends StatefulWidget {
  const HomeFormView({super.key});

  @override
  State<HomeFormView> createState() => _HomeFormViewState();
}

class _HomeFormViewState extends State<HomeFormView> {
  final formKey = GlobalKey<FormState>();
  final inputCepController = TextEditingController();
  final cepMaskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();

    inputCepController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: inputCepController,
            inputFormatters: [cepMaskFormatter],
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'CEP',
              hintText: 'Informe o CEP',
            ),
            validator: (value) {
              if (value != null && value.trim().isEmpty) {
                return 'O CEP é obrigatório.';
              }

              if (inputCepController.text.length < 9) {
                return 'O CEP está incompleto.';
              }

              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Buscar CEP'),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                var cep = inputCepController.text.trim();

                await ConsultCepRepository().getCep(cep);
              }
            },
          ),
        ],
      ),
    );
  }
}
