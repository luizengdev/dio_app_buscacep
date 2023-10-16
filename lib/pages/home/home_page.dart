import 'package:dio_app_buscacep/pages/historic/historic_page.dart';
import 'package:dio_app_buscacep/pages/home/home_controller.dart';
import 'package:dio_app_buscacep/pages/home/views/home_cep_actual_view.dart';
import 'package:dio_app_buscacep/pages/home/views/home_form_view.dart';
import 'package:dio_app_buscacep/repositories/back4app_cep_repository.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Back4appCepRepository().getAllAddresses();
  }

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('CONSULTA VIA CEP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HomeFormView(),
              Visibility(
                visible: homeController.isLoadingCepActual.value,
                replacement: const HomeCepActualView(),
                child: const Center(child: CircularProgressIndicator()),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('HISTÓRICO'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoricPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
