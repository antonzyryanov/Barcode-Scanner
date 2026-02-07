import '../../../../models/shop/shop_item.dart';

abstract class GoodsInStockRepositoryProtocol {
  Future<ShopItem> retrieveGoodsInStock(String scannedString);
}
