import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/events/data_layer_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/shop_goods_availability/protocols/goods_in_stock_repository_protocol.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/state/data_layer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/services/app_logger.dart';

class DataLayerBloc extends Bloc<DataLayerEvent, DataLayerState> {
  final GoodsInStockRepositoryProtocol worker;
  final AppLogger logger;

  DataLayerBloc({required this.worker, required this.logger})
    : super(DataLayerInitial()) {
    logger.log('DataLayerBloc created', tag: 'DataLayerBloc');
    on<RetrieveDataEvent>((event, emit) async {
      logger.log(
        'RetrieveDataEvent: ${event.scannedString}',
        tag: 'DataLayerBloc',
      );
      emit(DataLayerLoading());
      try {
        final data = await worker.retrieveGoodsInStock(event.scannedString);
        logger.log('GoodsInStock retrieved: $data', tag: 'DataLayerBloc');
        emit(DataLayerLoaded(data));
      } catch (e, st) {
        logger.error(
          'Error retrieving goods: $e',
          tag: 'DataLayerBloc',
          error: e,
          stackTrace: st,
        );
        emit(DataLayerError(e.toString()));
      }
    });
  }

  Future<void> retrieveData(String scannedString) async {
    add(RetrieveDataEvent(scannedString));
  }
}
