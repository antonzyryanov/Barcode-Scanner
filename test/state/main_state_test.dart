import 'package:anton_zyryanov_barcode_scanner/bloc/main%20bloc/state/main_state.dart';
import 'package:anton_zyryanov_barcode_scanner/models/shop/shop_item.dart';
import 'package:flutter_test/flutter_test.dart';

// Применение принципа Barbara Liskov Substitution Principle.
// Гарантия того, что в будущем случайно не попытаются снять протокол
// с нижеописанных классов.
// Применение принципа Single Responsibility в одной из его формулировок (Только один актор
// может работать с сущностью). В будущем другой актор
// (в данном случае другой программист), не сможет случайно поменять ожидаемое поведение сущностей,
// поменяв внутри поведение copyWith(...).
// Для окончательной практической реализации нужен
// CI на пуш в ветку с обязательным автоматическим прохождением тестов

void main() {
  group('MainState', () {
    group('MainInitial', () {
      test('is a MainState', () {
        expect(MainInitial(), isA<MainState>());
      });
    });

    group('MainLoading', () {
      test('is a MainState', () {
        expect(MainLoading(), isA<MainState>());
      });
    });

    group('MainScanResult', () {
      test('is a MainState', () {
        expect(MainScanResult('test'), isA<MainState>());
      });

      test('has correct result', () {
        const testResult = 'az_barcode_sneakers_123';
        final state = MainScanResult(testResult);
        expect(state.result, equals(testResult));
      });
    });

    group('copyWith', () {
      test('copies with new shopItem', () {
        final originalItem = ShopItem(
          imageUrl: 'https://example.com/original.jpg',
          name: 'Original',
          sizesInStock: {'40': 5},
        );
        final newItem = ShopItem(
          imageUrl: 'https://example.com/new.jpg',
          name: 'New',
          sizesInStock: {'42': 10},
        );

        final originalState = MainDataLoaded(shopItem: originalItem);
        final newState = originalState.copyWith(shopItem: newItem);

        expect(newState.shopItem, equals(newItem));
        expect(newState.error, isNull);
      });

      test('copies with new error', () {
        final shopItem = ShopItem(
          imageUrl: 'https://example.com/image.jpg',
          name: 'Test',
          sizesInStock: {'42': 5},
        );

        final originalState = MainDataLoaded(shopItem: shopItem);
        final newState = originalState.copyWith(error: 'New error');

        expect(newState.shopItem, equals(shopItem));
        expect(newState.error, equals('New error'));
      });

      test('copies without any changes', () {
        final shopItem = ShopItem(
          imageUrl: 'https://example.com/image.jpg',
          name: 'Test',
          sizesInStock: {'42': 5},
        );

        final originalState = MainDataLoaded(
          shopItem: shopItem,

          error: 'Some error',
        );
        final newState = originalState.copyWith();

        expect(newState.shopItem, equals(shopItem));
        expect(newState.error, equals('Some error'));
      });

      test('copies with all new values', () {
        final originalItem = ShopItem(
          imageUrl: 'https://example.com/original.jpg',
          name: 'Original',
          sizesInStock: {'40': 5},
        );
        final newItem = ShopItem(
          imageUrl: 'https://example.com/new.jpg',
          name: 'New',
          sizesInStock: {'42': 10},
        );

        final originalState = MainDataLoaded(
          shopItem: originalItem,
          error: 'Old error',
        );
        final newState = originalState.copyWith(
          shopItem: newItem,
          error: 'New error',
        );

        expect(newState.shopItem, equals(newItem));
        expect(newState.error, equals('New error'));
      });
    });
  });
}
