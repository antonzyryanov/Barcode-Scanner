import 'dart:async';

import 'package:anton_zyryanov_barcode_scanner/bloc/data%20layer%20bloc/data_layer_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data%20layer%20bloc/shop%20goods%20availability/protocols/goods_in_stock_repository_protocol.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data%20layer%20bloc/state/data_layer_state.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main%20bloc/events/main_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main%20bloc/state/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final DataLayerBloc _dataLayerBloc;
  late final StreamSubscription _dataLayerSubscription;

  MainBloc({required GoodsInStockRepositoryProtocol worker})
    : _dataLayerBloc = DataLayerBloc(worker: worker),
      super(MainLoaderShown()) {
    _dataLayerSubscription = _dataLayerBloc.stream.listen((state) {
      if (state is DataLayerLoaded) {
        add(DataLayerDataLoaded(state.item));
      } else if (state is DataLayerError) {
        add(DataLayerDataError(state.message));
      }
    });

    on<StartScanningEvent>((event, emit) async {
      emit(MainLoading());
    });

    on<SetScanResultEvent>((event, emit) async {
      emit(MainScanResult(event.result));
      await _dataLayerBloc.retrieveData(event.result);
    });

    on<DataLayerDataLoaded>((event, emit) {
      emit(MainDataLoaded(shopItem: event.item));
    });

    on<DataLayerDataError>((event, emit) {
      emit(MainDataLoaded(error: event.message));
    });

    on<ResetMainStateEvent>((event, emit) {
      emit(MainInitial());
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (!isClosed) {
        add(ResetMainStateEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _dataLayerSubscription.cancel();
    _dataLayerBloc.close();
    return super.close();
  }
}
