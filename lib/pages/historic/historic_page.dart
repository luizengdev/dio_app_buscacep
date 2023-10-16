import 'package:dio_app_buscacep/pages/historic/modals/edit_address_modal.dart';
import 'package:dio_app_buscacep/pages/home/home_controller.dart';
import 'package:dio_app_buscacep/repositories/back4app_cep_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  var homeController = Get.put(HomeController());
  ScrollController scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    Back4appCepRepository().getListCep(currentPage);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        currentPage++;
        Back4appCepRepository().getListCep(currentPage);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    homeController.listCeps.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VIA CEP'),
        centerTitle: true,
      ),
      body: Obx(
        () => Visibility(
          visible: homeController.isLoadingListCep.value,
          replacement: Visibility(
            visible: homeController.listCeps.isNotEmpty,
            replacement: const Center(
              child: Text('Não exite endereços salvos.'),
            ),
            child: ListView.builder(
              itemCount: homeController.listCeps.length,
              itemBuilder: (_, index) {
                final address = homeController.listCeps[index];

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CEP: ${address.cep}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Estado: ${address.state}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Cidade: ${address.city}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Bairro: ${address.neighborhood}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Rua: ${address.street}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return EditAddressModal(
                                  address: homeController.listCeps[index],
                                );
                              },
                            );
                          },
                          color: Colors.blue,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Confirmar exclusão?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        var objectId = homeController
                                            .listCeps[index].objectId;
                                        await Back4appCepRepository()
                                            .delete(objectId!);

                                        setState(() {
                                          homeController.listCeps
                                              .removeAt(index);
                                        });

                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Excluir',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
