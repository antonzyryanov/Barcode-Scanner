import 'package:anton_zyryanov_barcode_scanner/bloc/data%20layer%20bloc/shop%20goods%20availability/protocols/goods_in_stock_repository_protocol.dart';
import 'package:anton_zyryanov_barcode_scanner/models/shop/shop_item.dart';

class GoodsInStockMockRepository implements GoodsInStockRepositoryProtocol {
  @override
  Future<ShopItem> retrieveGoodsInStock(String scannedString) async {
    await Future.delayed(Duration(seconds: 3));
    switch (scannedString) {
      case 'az_barcode_sneakers_1':
        return ShopItem(
          imageUrl:
              'https://stoneforest.ru/wp-content/uploads/2018/12/krossovki-air-jordan-11-concord.jpg',
          name: 'Sneakers: Jordan 11 Retro Concord',
          sizesInStock: {
            '7 US': 0,
            '8 US': 4,
            '9 US': 5,
            '10 US': 3,
            '11 US': 2,
            '12 US': 1,
          },
        );
      case 'az_barcode_sneakers_2':
        return ShopItem(
          imageUrl:
              'https://100wears.com/wp-content/uploads/2022/12/Glam-2-1024x768.jpg',
          name: 'Sneakers: Jordan 11 Cherry',
          sizesInStock: {
            '7 US': 2,
            '8 US': 3,
            '9 US': 3,
            '10 US': 2,
            '11 US': 0,
            '12 US': 0,
          },
        );
      case 'az_barcode_sneakers_3':
        return ShopItem(
          imageUrl:
              'https://5.kixify.com/sites/default/files/imagecache/product_full/product/2019/08/06/p_27385706_153666146_111814.jpg',
          name: 'Jordan 2 Melo',
          sizesInStock: {
            '7 US': 5,
            '8 US': 6,
            '9 US': 1,
            '10 US': 0,
            '11 US': 0,
            '12 US': 0,
          },
        );
      case 'az_barcode_sneakers_4':
        return ShopItem(
          imageUrl:
              'https://i.pinimg.com/736x/81/33/1f/81331f058149c90b738470b28b224d4a.jpg',
          name: 'Uptempo 96 Gym Red',
          sizesInStock: {
            '7 US': 2,
            '8 US': 2,
            '9 US': 2,
            '10 US': 4,
            '11 US': 2,
            '12 US': 1,
          },
        );
      case 'az_barcode_sneakers_5':
        return ShopItem(
          imageUrl:
              'https://cdn.shopify.com/s/files/1/0221/7290/files/Resize_1_large.jpg?v=1506589011',
          name: 'Uptempo 96 Knicks',
          sizesInStock: {
            '7 US': 0,
            '8 US': 6,
            '9 US': 7,
            '10 US': 3,
            '11 US': 2,
            '12 US': 0,
          },
        );
      case 'az_barcode_sneakers_6':
        return ShopItem(
          imageUrl:
              'https://cdn.sanity.io/images/c1chvb1i/production/65bc97ab0cf434a848f057dad165282d0e4e1e44-1100x735.jpg',
          name: 'Air Force 1 White',
          sizesInStock: {
            '7 US': 3,
            '8 US': 7,
            '9 US': 8,
            '10 US': 6,
            '11 US': 5,
            '12 US': 2,
          },
        );
      case 'az_barcode_sneakers_7':
        return ShopItem(
          imageUrl:
              'https://sneakernews.com/wp-content/uploads/2016/07/air-jordan-9-kobe-bryant-pe-2016.jpg',
          name: 'Jordan 9 Lakers',
          sizesInStock: {
            '7 US': 0,
            '8 US': 0,
            '9 US': 0,
            '10 US': 0,
            '11 US': 1,
            '12 US': 0,
          },
        );
      case 'az_barcode_sneakers_8':
        return ShopItem(
          imageUrl:
              'https://sneakernews.com/wp-content/uploads/2020/06/air-jordan-13-flint-414571-404-0.jpg',
          name: 'Jordan 13 Flint',
          sizesInStock: {
            '7 US': 4,
            '8 US': 5,
            '9 US': 2,
            '10 US': 3,
            '11 US': 0,
            '12 US': 0,
          },
        );
      case 'az_barcode_sneakers_9':
        return ShopItem(
          imageUrl:
              '/https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEimzhPZJFRqDjcodyCBjGlK_A4w8nNzdEQUz7X_BluvtYeJ0c8Eq2FgGFbIDQLWVVvE2uIlioXBXcWNdXPuHYJ61kTrD8vmTS9jJOa-Ut5kKeyL8XUco_E4oip7L7-arHP9vvc2ruXSnbQ/s1600/air-jordan-retro-13-ray-allen-release-reminder-03.jpg',
          name: 'Jordan 13 Ray Allen',
          sizesInStock: {
            '7 US': 0,
            '8 US': 0,
            '9 US': 0,
            '10 US': 0,
            '11 US': 0,
            '12 US': 1,
          },
        );
      case 'az_barcode_sneakers_10':
        return ShopItem(
          imageUrl:
              'https://sneakernews.com/wp-content/uploads/2024/08/air-jordan-12-taxi-2025-release-info-5.jpg',
          name: 'Jordan 12 Retro Taxi',
          sizesInStock: {
            '7 US': 7,
            '8 US': 5,
            '9 US': 7,
            '10 US': 9,
            '11 US': 9,
            '12 US': 2,
          },
        );
      default:
        return ShopItem(
          imageUrl:
              'https://images.icon-icons.com/945/PNG/512/Office_-12_icon-icons.com_73953.png',
          name: 'Item not found in shop',
          sizesInStock: {},
        );
    }
  }
}
