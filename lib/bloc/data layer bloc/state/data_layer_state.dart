import 'package:anton_zyryanov_barcode_scanner/models/shop/shop_item.dart';

abstract class DataLayerState {}

class DataLayerInitial extends DataLayerState {}

class DataLayerLoading extends DataLayerState {}

class DataLayerLoaded extends DataLayerState {
  final ShopItem item;
  DataLayerLoaded(this.item);
}

class DataLayerError extends DataLayerState {
  final String message;
  DataLayerError(this.message);
}
