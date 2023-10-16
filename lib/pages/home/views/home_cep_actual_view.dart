import 'package:dio_app_buscacep/pages/home/adapters/info_cep_adapter.dart';
import 'package:dio_app_buscacep/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCepActualView extends StatefulWidget {
  const HomeCepActualView({super.key});

  @override
  State<HomeCepActualView> createState() => _HomeCepActualViewState();
}

class _HomeCepActualViewState extends State<HomeCepActualView> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var cep = homeController.viacepActual.value.cep ?? '';
      var state = homeController.viacepActual.value.uf ?? '';
      var city = homeController.viacepActual.value.localidade ?? '';
      var neighborhood = homeController.viacepActual.value.bairro ?? '';
      var street = homeController.viacepActual.value.logradouro ?? '';

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const Text(
            'ÚLTIMO CEP CONSULTADO',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          InfoCepAdapter(label: 'CEP', value: cep),
          InfoCepAdapter(label: 'Estado', value: state),
          InfoCepAdapter(label: 'Cidade', value: city),
          InfoCepAdapter(label: 'Bairro', value: neighborhood),
          InfoCepAdapter(label: 'Rua', value: street),
          const SizedBox(height: 20),
        ],
      );
    });
  }
}
