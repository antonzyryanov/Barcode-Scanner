import 'package:anton_zyryanov_barcode_scanner/bloc/handbook_bloc/handbook_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/responsive_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/typography_config.dart';
import 'package:anton_zyryanov_barcode_scanner/ui/components/animated_fade_slide_widget.dart';
import 'package:flutter/material.dart';
import 'widgets/section_widget.dart';
import 'widgets/handbook_tab_bar.dart';

class HandbookScreen extends StatefulWidget {
  final HandbookBloc bloc;
  const HandbookScreen({super.key, required this.bloc});

  @override
  State<HandbookScreen> createState() => _HandbookScreenState();
}

class _HandbookScreenState extends State<HandbookScreen>
    with TickerProviderStateMixin {
  bool loading = true;
  int _selectedTabIndex = 0;
  late final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    widget.bloc.fetchAllSections(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveConfig.getResponsivePaddingHorizontal(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: IconSizingConfig.appBarIconSize,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Sneakers Handbook',
          style: HeadingStyles.headingMedium.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        backgroundColor: AppTheme.darkRed,
        elevation: 4,
      ),
      bottomNavigationBar: HandbookTabBar(
        selectedIndex: _selectedTabIndex,
        onTap: (idx) {
          setState(() {
            _selectedTabIndex = idx;
            _pageController.jumpToPage(idx);
          });
        },
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : AnimatedFadeSlideWidget(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (idx) {
                    setState(() {
                      _selectedTabIndex = idx;
                    });
                  },
                  children: [
                    for (final section in [
                      widget.bloc.firstSectionModel,
                      widget.bloc.secondSectionModel,
                      widget.bloc.thirdSectionModel,
                      widget.bloc.fourthSectionModel,
                      widget.bloc.fifthSectionModel,
                    ])
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: SectionWidget(
                          section: section,
                          key: ValueKey(section?.name),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
