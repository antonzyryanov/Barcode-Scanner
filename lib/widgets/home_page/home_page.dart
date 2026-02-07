import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/events/main_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/state/main_state.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/error_presenter.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/sneaker_loader_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home_page/ui_builder/home_page_ui_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mainBloc = context.read<MainBloc>();
    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: AppBar(title: const Text('Sneakers Store')),
      body: BlocListener<MainBloc, MainState>(
        listener: (context, state) {
          if (state is MainDataLoaded && state.error != null) {
            ErrorPresenter.showError(context: context, error: state.error!);
            closeShownError(context, mainBloc);
          }
        },
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state is MainLoaderShown) {
              return const SneakerLoaderWidget();
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: HomePageUiBuilder.buildHomePageUI(
                        context,
                        state,
                        mainBloc,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void closeShownError(BuildContext context, MainBloc mainBloc) {
    const errorShowingTimeSeconds = 3;
    Future.delayed(const Duration(seconds: errorShowingTimeSeconds), () {
      if (!context.mounted) {
        return;
      }
      mainBloc.add(ResetMainStateEvent());
    });
  }
}
