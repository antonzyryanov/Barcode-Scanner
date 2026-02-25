import 'dart:async';

import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/data_layer_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/shop_goods_availability/protocols/goods_in_stock_repository_protocol.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/data_layer_bloc/state/data_layer_state.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/events/main_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/state/main_state.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/timing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/models/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/services/app_logger.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/handbook_bloc/handbook_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final DataLayerBloc _dataLayerBloc;
  final HandbookBloc handbookBloc;
  final User user;
  final AppLogger logger;
  late final StreamSubscription _dataLayerSubscription;

  MainBloc({
    required GoodsInStockRepositoryProtocol worker,
    required this.user,
    required this.logger,
  }) : _dataLayerBloc = DataLayerBloc(worker: worker, logger: logger),
       handbookBloc = HandbookBloc(logger: logger),
       super(MainLoaderShown()) {
    logger.log('MainBloc created', tag: 'MainBloc');
    _dataLayerSubscription = _dataLayerBloc.stream.listen((state) {
      if (state is DataLayerLoaded) {
        logger.log('DataLayerLoaded event', tag: 'MainBloc');
        add(DataLayerDataLoaded(state.item));
      } else if (state is DataLayerError) {
        logger.error('DataLayerError event: ${state.message}', tag: 'MainBloc');
        add(DataLayerDataError(state.message));
      }
    });

    on<StartScanningEvent>((event, emit) async {
      emit(MainLoading());
    });

    on<SetScanResultEvent>((event, emit) async {
      emit(MainScanResult(event.result));
      Future.delayed(TimingConfig.scanResultDelay, () async {
        await _dataLayerBloc.retrieveData(event.result);
      });
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

    on<ResolveStartupStateEvent>((event, emit) {
      if (user.isSubscribed) {
        emit(MainInitial());
      } else {
        emit(OnboardingShowing());
      }
    });

    on<ShowPaywallEvent>((event, emit) {
      emit(PaywallShowing());
    });

    on<CompleteOnboardingEvent>((event, emit) {
      emit(MainInitial());
    });

    Future.delayed(TimingConfig.autoResetDelay, () {
      if (!isClosed) {
        add(ResolveStartupStateEvent());
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
