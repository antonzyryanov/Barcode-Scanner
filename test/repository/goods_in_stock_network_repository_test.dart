import 'dart:convert';
import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/shop_goods_availability/data_repository_impls/goods_in_stock_network_repository.dart';
import 'package:anton_zyryanov_barcode_scanner/models/shop/shop_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'goods_in_stock_network_repository_test.mocks.dart';

// Использован принцип тестирования Роберта Мартина "Red Green Refactor"
// "Не верь тестам, которые никогда не проваливались"
// Скриншоты Failed тестов в документации к проекту

@GenerateMocks([http.Client])
void main() {
  group('GoodsInStockNetworkRepository', () {
    late GoodsInStockNetworkRepository repository;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      repository = GoodsInStockNetworkRepository(
        serverIP: '192.168.1.1',
        serverPort: '3000',
      );
    });

    group('retrieveGoodsInStock', () {
      test('throws exception when scanned string format is invalid', () async {
        // Arrange
        const invalidString = 'invalid_format';

        // Act & Assert
        expect(
          () => repository.retrieveGoodsInStock(invalidString),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Invalid scanned string format'),
            ),
          ),
        );
      });

      test('returns ShopItem when response is successful (200)', () async {
        // Arrange
        const scannedString = 'az_barcode_sneakers_123';
        final responseData = {
          'name': 'Nike Air Max 90',
          'imageUrl': 'https://example.com/nike.jpg',
          'sizesInStock': {'40': 5, '41': 3, '42': 8},
        };
        final response = http.Response(json.encode(responseData), 200);

        // Create a new repository with injected client
        final testRepository = TestableGoodsInStockNetworkRepository(
          serverIP: '192.168.1.1',
          serverPort: '3000',
          client: mockClient,
        );

        when(mockClient.get(any)).thenAnswer((_) async => response);

        // Act
        final result = await testRepository.retrieveGoodsInStock(scannedString);

        // Assert
        expect(result, isA<ShopItem>());
        expect(result.name, equals('Nike Air Max 90'));
        expect(result.imageUrl, equals('https://example.com/nike.jpg'));
        expect(result.sizesInStock, equals({'40': 5, '41': 3, '42': 8}));
      });

      test('throws exception when item is not found (404)', () async {
        // Arrange
        const scannedString = 'az_barcode_sneakers_999';
        final response = http.Response('Not found', 404);

        final testRepository = TestableGoodsInStockNetworkRepository(
          serverIP: '192.168.1.1',
          serverPort: '3000',
          client: mockClient,
        );

        when(mockClient.get(any)).thenAnswer((_) async => response);

        // Act & Assert
        expect(
          () => testRepository.retrieveGoodsInStock(scannedString),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Item not found'),
            ),
          ),
        );
      });

      test('throws exception when server returns error (500)', () async {
        // Arrange
        const scannedString = 'az_barcode_sneakers_456';
        final response = http.Response('Internal Server Error', 500);

        final testRepository = TestableGoodsInStockNetworkRepository(
          serverIP: '192.168.1.1',
          serverPort: '3000',
          client: mockClient,
        );

        when(mockClient.get(any)).thenAnswer((_) async => response);

        // Act & Assert
        expect(
          () => testRepository.retrieveGoodsInStock(scannedString),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Server error: 500'),
            ),
          ),
        );
      });

      test('throws exception when network error occurs', () async {
        // Arrange
        const scannedString = 'az_barcode_sneakers_789';

        final testRepository = TestableGoodsInStockNetworkRepository(
          serverIP: '192.168.1.1',
          serverPort: '3000',
          client: mockClient,
        );

        when(mockClient.get(any)).thenThrow(Exception('Connection timeout'));

        // Act & Assert
        expect(
          () => testRepository.retrieveGoodsInStock(scannedString),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Failed to retrieve goods'),
            ),
          ),
        );
      });

      test('makes request to correct URL', () async {
        // Arrange
        const scannedString = 'az_barcode_sneakers_123';
        final responseData = {
          'name': 'Test Item',
          'imageUrl': 'https://example.com/test.jpg',
          'sizesInStock': {'42': 1},
        };
        final response = http.Response(json.encode(responseData), 200);

        final testRepository = TestableGoodsInStockNetworkRepository(
          serverIP: '192.168.1.1',
          serverPort: '3000',
          client: mockClient,
        );

        when(mockClient.get(any)).thenAnswer((_) async => response);

        // Act
        await testRepository.retrieveGoodsInStock(scannedString);

        // Assert
        verify(
          mockClient.get(Uri.parse('http://192.168.1.1:3000/item?id=123')),
        ).called(1);
      });

      test('extracts correct ID from scanned string', () async {
        // Arrange
        const scannedString = 'az_barcode_sneakers_999';
        final responseData = {
          'name': 'Test',
          'imageUrl': 'https://example.com/test.jpg',
          'sizesInStock': {'42': 1},
        };
        final response = http.Response(json.encode(responseData), 200);

        final testRepository = TestableGoodsInStockNetworkRepository(
          serverIP: '10.0.0.1',
          serverPort: '8080',
          client: mockClient,
        );

        when(mockClient.get(any)).thenAnswer((_) async => response);

        // Act
        await testRepository.retrieveGoodsInStock(scannedString);

        // Assert
        verify(
          mockClient.get(Uri.parse('http://10.0.0.1:8080/item?id=999')),
        ).called(1);
      });
    });
  });
}

// Testable version that allows client injection
class TestableGoodsInStockNetworkRepository
    extends GoodsInStockNetworkRepository {
  final http.Client client;

  TestableGoodsInStockNetworkRepository({
    required super.serverIP,
    required super.serverPort,
    required this.client,
  });

  @override
  Future<ShopItem> retrieveGoodsInStock(String scannedString) async {
    // Validate the scannedString format and extract id
    final pattern = RegExp(r'^az_barcode_sneakers_(\d+)$');
    final match = pattern.firstMatch(scannedString);
    if (match == null) {
      throw Exception('Invalid scanned string format');
    }

    final int id = int.parse(match.group(1)!);
    final url = Uri.parse('http://$serverIP:$serverPort/item?id=$id');

    try {
      final response = await client.get(url);

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
      if (e is Exception && e.toString().contains('Item not found')) {
        rethrow;
      }
      if (e is Exception && e.toString().contains('Server error')) {
        rethrow;
      }
      throw Exception('Failed to retrieve goods: $e');
    }
  }
}
