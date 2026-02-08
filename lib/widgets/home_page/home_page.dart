import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/events/main_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/state/main_state.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/animation_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
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
      appBar: AppBar(
        title: const Text('Sneakers Store'),
        backgroundColor: AppTheme.background,
        elevation: 4,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppTheme.textPrimary),
        toolbarHeight: 70,
        titleTextStyle: const TextStyle(
          color: AppTheme.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BlocListener<MainBloc, MainState>(
        listener: (context, state) {
          if (state is MainDataLoaded && state.error != null) {
            ErrorPresenter.showError(context: context, error: state.error!);
            closeShownError(context, mainBloc);
          }
        },
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: TransitionDurations.pageTransitionDuration,
              switchInCurve: AnimationCurves.fadeInCurve,
              switchOutCurve: AnimationCurves.fadeOutCurve,
              transitionBuilder: (Widget child, Animation<double> animation) {
                final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
                    .animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: AnimationCurves.fadeInCurve,
                      ),
                    );

                final slideAnimation =
                    Tween<Offset>(
                      begin: const Offset(0, 0.08),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: AnimationCurves.slideUpCurve,
                      ),
                    );

                return FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: child,
                  ),
                );
              },
              child: _buildContent(context, state, mainBloc),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    MainState state,
    MainBloc mainBloc,
  ) {
    if (state is MainLoaderShown) {
      return const SneakerLoaderWidget(key: ValueKey('loader'));
    }

    return LayoutBuilder(
      key: ValueKey('content_${state.runtimeType}'),
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
