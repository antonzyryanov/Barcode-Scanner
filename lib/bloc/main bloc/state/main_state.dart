import 'package:anton_zyryanov_barcode_scanner/models/shop/shop_item.dart';

abstract class MainState {}

class MainLoaderShown extends MainState {}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class MainScanResult extends MainState {
  final String result;
  MainScanResult(this.result);
}

class MainDataLoaded extends MainState {
  final ShopItem? shopItem;
  final String? error;

  MainDataLoaded({this.shopItem, this.error});

  MainDataLoaded copyWith({ShopItem? shopItem, String? error}) {
    return MainDataLoaded(
      shopItem: shopItem ?? this.shopItem,
      error: error ?? this.error,
    );
  }
}
