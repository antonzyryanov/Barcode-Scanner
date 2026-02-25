import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/shop_goods_availability/protocols/goods_in_stock_repository_protocol.dart';
import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:anton_zyryanov_barcode_scanner/models/shop/shop_item.dart';
import 'package:anton_zyryanov_barcode_scanner/services/app_logger.dart';

class GoodsInStockNetworkRepository implements GoodsInStockRepositoryProtocol {
  String serverIP;
  String serverPort;
  final AppLogger logger;

  GoodsInStockNetworkRepository({
    required this.serverIP,
    required this.serverPort,
    required this.logger,
  });

  @override
  Future<ShopItem> retrieveGoodsInStock(String scannedString) async {
    logger.log(
      'retrieveGoodsInStock called with: $scannedString',
      tag: 'GoodsInStockNetworkRepository',
    );
    if (serverIP.isEmpty || serverPort.isEmpty) {
      logger.error(
        'Backend config missing',
        tag: 'GoodsInStockNetworkRepository',
      );
      throw Exception(AppLocalizations.current.backendConfigMissing);
    }

    final pattern = RegExp(r'^az_barcode_sneakers_(\d+)$');
    final match = pattern.firstMatch(scannedString);
    if (match == null) {
      logger.error(
        'Invalid scanned format: $scannedString',
        tag: 'GoodsInStockNetworkRepository',
      );
      throw Exception(AppLocalizations.current.invalidScannedFormat);
    }

    final int id = int.parse(match.group(1)!);

    final url = Uri.parse('http://$serverIP:$serverPort/item?id=$id');
    logger.log('Requesting URL: $url', tag: 'GoodsInStockNetworkRepository');

    try {
      final response = await http.get(url);
      logger.log(
        'Response status: ${response.statusCode}',
        tag: 'GoodsInStockNetworkRepository',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final shopItem = ShopItem.fromJson(data);
        logger.log(
          'ShopItem loaded: ${shopItem.name}',
          tag: 'GoodsInStockNetworkRepository',
        );
        return shopItem;
      } else if (response.statusCode == 404) {
        logger.error('Item not found', tag: 'GoodsInStockNetworkRepository');
        throw Exception(AppLocalizations.current.itemNotFound);
      } else {
        logger.error(
          'Server error: ${response.statusCode}',
          tag: 'GoodsInStockNetworkRepository',
        );
        throw Exception(
          AppLocalizations.current.serverError(response.statusCode),
        );
      }
    } catch (e) {
      logger.error(
        'Failed to retrieve goods: $e',
        tag: 'GoodsInStockNetworkRepository',
      );
      throw Exception(AppLocalizations.current.failedRetrieveGoods(e));
    }
  }
}
