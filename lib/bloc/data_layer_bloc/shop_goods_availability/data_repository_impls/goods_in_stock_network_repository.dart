import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/shop_goods_availability/protocols/goods_in_stock_repository_protocol.dart';
import 'package:anton_zyryanov_barcode_scanner/models/shop/shop_item.dart';

class GoodsInStockNetworkRepository implements GoodsInStockRepositoryProtocol {
  String serverIP;
  String serverPort;

  GoodsInStockNetworkRepository({
    required this.serverIP,
    required this.serverPort,
  });

  @override
  Future<ShopItem> retrieveGoodsInStock(String scannedString) async {
    final pattern = RegExp(r'^az_barcode_sneakers_(\d+)$');
    final match = pattern.firstMatch(scannedString);
    if (match == null) {
      throw Exception('Invalid scanned string format');
    }

    final int id = int.parse(match.group(1)!);

    final url = Uri.parse('http://$serverIP:$serverPort/item?id=$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final shopItem = ShopItem.fromJson(data);
        return shopItem;
      } else if (response.statusCode == 404) {
        throw Exception('Item not found');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to retrieve goods: $e');
    }
  }
}
