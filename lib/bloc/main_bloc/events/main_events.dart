import 'package:anton_zyryanov_barcode_scanner/models/shop/shop_item.dart';

abstract class MainEvent {}

class StartScanningEvent extends MainEvent {}

class SetScanResultEvent extends MainEvent {
  final String result;
  SetScanResultEvent(this.result);
}

class ResetMainStateEvent extends MainEvent {}

class DataLayerDataLoaded extends MainEvent {
  final ShopItem item;
  DataLayerDataLoaded(this.item);
}

class DataLayerDataError extends MainEvent {
  final String message;
  DataLayerDataError(this.message);
}
