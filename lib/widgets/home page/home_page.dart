import 'package:anton_zyryanov_barcode_scanner/bloc/main%20bloc/events/main_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main%20bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main%20bloc/state/main_state.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/error_presenter.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/sneaker_loader_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home%20page/ui%20builder/home_page_ui_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainBloc = context.read<MainBloc>();
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(title: const Text('Sneakers Store')),
      body: BlocListener<MainBloc, MainState>(
        listener: (context, state) {
          if (state is MainDataLoaded && state.error != null) {
            ErrorPresenter.showError(context: context, state: state);
            Future.delayed(const Duration(seconds: 3), () {
              if (!context.mounted) {
                return;
              }
              mainBloc.add(ResetMainStateEvent());
            });
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
                      child: HomePageUiBuilder.buildContent(
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
}
