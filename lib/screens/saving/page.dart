import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/generated/assets.gen.dart';
import 'package:beer_app/styles.dart';
import 'package:beer_app/utils/custom_function.dart';
import 'package:beer_app/widget/activity_item.dart';
import 'package:beer_app/widget/empty_screen.dart';
import 'package:beer_app/widget/title_bar.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';

class SavingPage extends StatefulWidget {
  const SavingPage({Key? key}) : super(key: key);

  @override
  _SavingPageState createState() => _SavingPageState();
}

class _SavingPageState extends State<SavingPage> {
  final SavingBloc _bloc = SavingBloc();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text('Сбережения', style: BS.bold18.apply(color: BC.brandWhite)),
      centerTitle: true,
      leading: IconButton(
        icon: Assets.icons.iLeftArrow.svg(color: BC.brandWhite),
        onPressed: () => context.router.pop(),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return StreamBuilder<ScreenState>(
        stream: _bloc.state,
        initialData: _bloc.currentState,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state != null &&
              (state.finances?.data?.isNotEmpty ?? false) &&
              (state.savings?.data?.isNotEmpty ?? false)) {
            final list = state.finances!.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomTitleBar(
                      title: 'СБЕРЕЖЕНИЕ ЗА МЕСЯЦ', onTap: null),
                  const SizedBox(height: 6),
                  if (list != null && list.isNotEmpty)
                    for (var i = 0; list.length > i; i++)
                      if (list[i].type == FinanceTypeEnum.SAVING)
                        CustomActivityItem(
                          item: list[i],
                          canDelete: true,
                          onDelete: () => _bloc.deleteItem(list[i].id),
                        )
                ],
              ),
            );
          } else {
            return const CustomEmptyScreen();
          }
        });
  }

  Widget _lineInformation(String s, double allIncome) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s,
          style: BS.reg12.apply(color: BC.brandWhite),
        ),
        const SizedBox(width: 4),
        Text(
          parseBigAmount((allIncome)) + '₴',
          style: BS.reg12.apply(color: BC.brandYellow),
        ),
      ],
    );
  }
}
