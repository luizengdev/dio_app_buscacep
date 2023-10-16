import 'dart:convert';

import 'package:dio_app_buscacep/models/viacep_model.dart';
import 'package:dio_app_buscacep/pages/home/home_controller.dart';
import 'package:dio_app_buscacep/repositories/back4app_cep_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ConsultCepRepository {
  Future<void> getCep(String cep) async {
    var homeController = Get.put(HomeController());

    try {
      homeController.isLoadingCepActual.value = true;

      var response = await http.get(
        Uri.parse('https://viacep.com.br/ws/$cep/json/'),
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        homeController.viacepActual.value = ViaCepModel.fromJson(json);

        await Back4appCepRepository().getAllAddresses();

        var existAddress = homeController.verifyExist(
          homeController.viacepActual.value,
        );

        if (!existAddress) {
          await Back4appCepRepository().saveCep(
            homeController.viacepActual.value.toAddress(),
          );
        }
      }

      homeController.isLoadingCepActual.value = false;
    } catch (e) {
      printError(info: e.toString());
      homeController.isLoadingCepActual.value = false;
    }
  }
}
