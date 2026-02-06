import 'package:anton_zyryanov_barcode_scanner/models/shop/shop_item.dart';
import 'package:flutter_test/flutter_test.dart';

// Применение принципа Single Responsibility в одной из его формулировок (Только один актор
// может работать с сущностью). В будущем другой актор
// (в данном случае другой программист), не сможет случайно поменять ожидаемое поведение сущностей,
// поменяв внутри поведение конструкторов. Для окончательной практической реализации нужен
// CI на пуш в ветку с обязательным автоматическим прохождением тестов

void main() {
  group('ShopItem', () {
    test('creates instance with all properties', () {
      final shopItem = ShopItem(
        imageUrl: 'https://example.com/sneakers.jpg',
        name: 'Nike Air Max',
        sizesInStock: {'40': 10, '41': 5, '42': 8},
      );

      expect(shopItem.imageUrl, equals('https://example.com/sneakers.jpg'));
      expect(shopItem.name, equals('Nike Air Max'));
      expect(shopItem.sizesInStock, equals({'40': 10, '41': 5, '42': 8}));
    });

    group('fromJson', () {
      test('creates ShopItem from valid JSON', () {
        final json = {
          'name': 'Adidas Ultraboost',
          'imageUrl': 'https://example.com/adidas.jpg',
          'sizesInStock': {'39': 3, '40': 7, '41': 12},
        };

        final shopItem = ShopItem.fromJson(json);

        expect(shopItem.name, equals('Adidas Ultraboost'));
        expect(shopItem.imageUrl, equals('https://example.com/adidas.jpg'));
        expect(shopItem.sizesInStock, equals({'39': 3, '40': 7, '41': 12}));
      });

      test('creates ShopItem from JSON with empty sizesInStock', () {
        final json = {
          'name': 'Out of Stock Item',
          'imageUrl': 'https://example.com/item.jpg',
          'sizesInStock': <String, int>{},
        };

        final shopItem = ShopItem.fromJson(json);

        expect(shopItem.name, equals('Out of Stock Item'));
        expect(shopItem.imageUrl, equals('https://example.com/item.jpg'));
        expect(shopItem.sizesInStock, isEmpty);
      });

      test('creates ShopItem from JSON with multiple sizes', () {
        final json = {
          'name': 'Running Shoes',
          'imageUrl': 'https://example.com/running.jpg',
          'sizesInStock': {
            '38': 5,
            '39': 10,
            '40': 15,
            '41': 20,
            '42': 12,
            '43': 8,
            '44': 3,
          },
        };

        final shopItem = ShopItem.fromJson(json);

        expect(shopItem.sizesInStock.length, equals(7));
        expect(shopItem.sizesInStock['40'], equals(15));
        expect(shopItem.sizesInStock['44'], equals(3));
      });

      test('handles string size keys in JSON', () {
        final json = {
          'name': 'Test Shoes',
          'imageUrl': 'https://example.com/test.jpg',
          'sizesInStock': {'42': 5, '43': 10},
        };

        final shopItem = ShopItem.fromJson(json);

        expect(shopItem.sizesInStock['42'], equals(5));
        expect(shopItem.sizesInStock['43'], equals(10));
      });
    });

    test('two ShopItems with same properties are equal', () {
      final shopItem1 = ShopItem(
        imageUrl: 'https://example.com/test.jpg',
        name: 'Test',
        sizesInStock: {'42': 5},
      );

      final shopItem2 = ShopItem(
        imageUrl: 'https://example.com/test.jpg',
        name: 'Test',
        sizesInStock: {'42': 5},
      );

      expect(shopItem1.name, equals(shopItem2.name));
      expect(shopItem1.imageUrl, equals(shopItem2.imageUrl));
      expect(shopItem1.sizesInStock, equals(shopItem2.sizesInStock));
    });
  });
}
