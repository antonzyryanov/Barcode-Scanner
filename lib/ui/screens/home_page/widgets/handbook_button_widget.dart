import 'package:flutter/material.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/ui/screens/handbook_screen/handbook_screen.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';

class HandbookButtonWidget extends StatelessWidget {
  final MainBloc mainBloc;
  const HandbookButtonWidget({Key? key, required this.mainBloc})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        mainBloc.logger.log('Handbook button tapped', tag: 'ModelFinderWidget');
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HandbookScreen(bloc: mainBloc.handbookBloc),
          ),
        );
      },
      child: SizedBox(
        width: IconSizingConfig.iconSmall,
        height: IconSizingConfig.iconSmall,
        child: Image.asset('assets/images/icons/handbook_icon.png'),
      ),
    );
  }
}
