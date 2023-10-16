import 'package:dio/dio.dart';
import 'package:dio_app_buscacep/models/address_model.dart';
import 'package:dio_app_buscacep/pages/home/home_controller.dart';
import 'package:get/get.dart';

class Back4appCepRepository {
  var homeController = Get.put(HomeController());
  var dio = Dio();

  Back4appCepRepository() {
    dio.options.headers['X-Parse-Application-Id'] =
        'UwsyKe4qWMGw5a1Iz06ho6wLwYjyWad5iazndvPp';
    dio.options.headers['X-Parse-REST-API-Key'] =
        'HNszGl5DeX6qkdIev01UvDG7vonb76aDUWipJN3T';
    dio.options.headers['content-type'] = 'application/json';
    dio.options.baseUrl = 'https://parseapi.back4app.com/classes';
  }

  Future<void> getListCep(int page) async {
    try {
      homeController.isLoadingListCep.value = true;

      int skip = (page - 1) * 10;

      var response = await dio.get(
        '/address',
        queryParameters: {'limit': 10, 'skip': skip},
      );

      homeController.listCeps.clear();

      homeController.listCeps.addAll(
        AddressBack4AppModel.fromJson(response.data).results,
      );

      homeController.isLoadingListCep.value = false;
    } catch (e) {
      printError(info: e.toString());
      homeController.isLoadingListCep.value = false;
    }
  }

  Future<void> getAllAddresses() async {
    try {
      var response = await dio.get('/address');

      homeController.listCeps.clear();

      homeController.listCeps.addAll(
        AddressBack4AppModel.fromJson(response.data).results,
      );
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<bool> saveCep(Address address) async {
    try {
      homeController.isLoadingListCep.value = true;

      var response = await dio.post(
        '/address',
        data: address.toJsonBack4App(),
      );

      homeController.isLoadingListCep.value = false;

      if (response.statusCode == 201) return true;

      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }

  Future<bool> updateCep(Address address) async {
    try {
      homeController.isLoadingListCep.value = true;

      var response = await dio.put(
        '/address/${address.objectId}',
        data: address.toJsonBack4App(),
      );

      homeController.isLoadingListCep.value = false;

      if (response.statusCode == 201) return true;

      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }

  Future<void> delete(String objectId) async {
    try {
      await dio.delete('/address/$objectId');
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
