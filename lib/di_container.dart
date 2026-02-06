import 'package:anton_zyryanov_barcode_scanner/app_settings.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data%20layer%20bloc/shop%20goods%20availability/data%20repository%20impls/goods_in_stock_mock_repository.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data%20layer%20bloc/shop%20goods%20availability/data%20repository%20impls/goods_in_stock_network_repository.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data%20layer%20bloc/shop%20goods%20availability/protocols/goods_in_stock_repository_protocol.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main%20bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home%20page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DIContainer {
  AppSettings appSettings = AppSettings();

  GoodsInStockRepositoryProtocol createDataLayerWorker() {
    if (appSettings.isMockOn) {
      print("[DIContainer] Using Mock Repository");
      return GoodsInStockMockRepository();
    } else {
      print("[DIContainer] Using Network Repository");
      return GoodsInStockNetworkRepository(
        serverIP: appSettings.SERVER_IP,
        serverPort: appSettings.SERVER_PORT,
      );
    }
  }

  Widget buildApp(BuildContext context) {
    final dataWorker = createDataLayerWorker();
    return MaterialApp(
      title: appSettings.appName,
      home: BlocProvider(
        create: (_) => MainBloc(worker: dataWorker),
        child: HomePage(),
      ),
    );
  }
}
