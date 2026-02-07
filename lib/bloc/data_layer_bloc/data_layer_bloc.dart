import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/events/data_layer_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/shop_goods_availability/protocols/goods_in_stock_repository_protocol.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/state/data_layer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataLayerBloc extends Bloc<DataLayerEvent, DataLayerState> {
  final GoodsInStockRepositoryProtocol worker;

  DataLayerBloc({required this.worker}) : super(DataLayerInitial()) {
    on<RetrieveDataEvent>((event, emit) async {
      emit(DataLayerLoading());
      try {
        final data = await worker.retrieveGoodsInStock(event.scannedString);
        emit(DataLayerLoaded(data));
      } catch (e) {
        emit(DataLayerError(e.toString()));
      }
    });
  }

  Future<void> retrieveData(String scannedString) async {
    add(RetrieveDataEvent(scannedString));
  }
}
