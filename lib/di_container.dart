import 'package:anton_zyryanov_barcode_scanner/app_settings.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/shop_goods_availability/data_repository_impls/goods_in_stock_mock_repository.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/shop_goods_availability/data_repository_impls/goods_in_stock_network_repository.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/shop_goods_availability/protocols/goods_in_stock_repository_protocol.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class DIContainer {
  AppSettings appSettings = AppSettings();

  GoodsInStockRepositoryProtocol createDataLayerWorker() {
    if (appSettings.isMockOn) {
      return GoodsInStockMockRepository();
    } else {
      return GoodsInStockNetworkRepository(
        serverIP: appSettings.serverIP,
        serverPort: appSettings.serverPort,
      );
    }
  }

  Widget buildApp(BuildContext context) {
    final dataWorker = createDataLayerWorker();
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: BlocProvider(
        create: (_) => MainBloc(worker: dataWorker),
        child: HomePageWidget(),
      ),
    );
  }
}
