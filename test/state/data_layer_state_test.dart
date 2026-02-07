import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/state/data_layer_state.dart';
import 'package:anton_zyryanov_barcode_scanner/models/shop/shop_item.dart';
import 'package:flutter_test/flutter_test.dart';

// Применение принципа Barbara Liskov Substitution Principle.
// Гарантия того, что в будущем случайно не попытаются снять протокол
// с нижеописанных классов.
// Применение принципа Single Responsibility в одной из его формулировок (Только один актор
// может работать с сущностью). В будущем другой актор
// (в данном случае другой программист), не сможет случайно поменять ожидаемое поведение сущностей,
// поменяв внутри поведение конструкторов.
// Для окончательной практической реализации нужен
// CI на пуш в ветку с обязательным автоматическим прохождением тестов.

void main() {
  group('DataLayerState', () {
    group('DataLayerInitial', () {
      test('is a DataLayerState', () {
        expect(DataLayerInitial(), isA<DataLayerState>());
      });
    });

    group('DataLayerLoading', () {
      test('is a DataLayerState', () {
        expect(DataLayerLoading(), isA<DataLayerState>());
      });
    });

    group('DataLayerLoaded', () {
      test('is a DataLayerState', () {
        final shopItem = ShopItem(
          imageUrl: 'https://example.com/image.jpg',
          name: 'Test Item',
          sizesInStock: {'42': 5},
        );
        expect(DataLayerLoaded(shopItem), isA<DataLayerState>());
      });

      test('has correct item', () {
        final shopItem = ShopItem(
          imageUrl: 'https://example.com/sneakers.jpg',
          name: 'Nike Air Max',
          sizesInStock: {'40': 10, '41': 5, '42': 8},
        );
        final state = DataLayerLoaded(shopItem);

        expect(state.item, equals(shopItem));
        expect(state.item.name, equals('Nike Air Max'));
        expect(state.item.imageUrl, equals('https://example.com/sneakers.jpg'));
        expect(state.item.sizesInStock, equals({'40': 10, '41': 5, '42': 8}));
      });
    });

    group('DataLayerError', () {
      test('is a DataLayerState', () {
        expect(DataLayerError('error'), isA<DataLayerState>());
      });

      test('has correct error message', () {
        const errorMessage = 'Network error occurred';
        final state = DataLayerError(errorMessage);

        expect(state.message, equals(errorMessage));
      });

      test('handles exception message', () {
        const errorMessage =
            'Exception: Failed to retrieve goods: Connection timeout';
        final state = DataLayerError(errorMessage);

        expect(state.message, contains('Failed to retrieve goods'));
        expect(state.message, contains('Connection timeout'));
      });
    });
  });
}
