import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/events/main_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/typography_config.dart';
import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:anton_zyryanov_barcode_scanner/ui/components/animated_button_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/ui/components/animated_fade_slide_widget.dart';
import 'package:flutter/material.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key, required this.mainBloc});

  final MainBloc mainBloc;

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final pageDescriptions = [
      localizations.onboardingPageOneText,
      localizations.onboardingPageTwoText,
    ];

    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: AppTheme.background),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    _currentPage == 0
                        ? 'assets/images/onboarding/onboarding_background_1.jpg'
                        : 'assets/images/onboarding/onboarding_background_2.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.35)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(SmallSpacing.spacing16),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  key: ValueKey(_currentPage),
                  children: [
                    const Spacer(),
                    AnimatedFadeSlideWidget(
                      key: ValueKey('onboarding_text_$_currentPage'),
                      child: Text(
                        pageDescriptions[_currentPage],
                        textAlign: TextAlign.center,
                        style: HeadingStyles.headingSmall.copyWith(
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: AnimatedButtonWidget(
                        onPressed: () {
                          if (_currentPage == 0) {
                            setState(() {
                              _currentPage = 1;
                            });
                          } else {
                            widget.mainBloc.add(CompleteOnboardingEvent());
                          }
                        },
                        child: Text(
                          localizations.continueButton,
                          style: const TextStyle(color: AppTheme.textOnButton),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
