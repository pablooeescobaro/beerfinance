import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/data/dto/spending.dart';
import 'package:beer_app/generated/assets.gen.dart';
import 'package:beer_app/screens/home/home_page.dart';
import 'package:beer_app/styles.dart';
import 'package:beer_app/utils/custom_function.dart';
import 'package:beer_app/widget/activity_item.dart';
import 'package:beer_app/widget/empty_screen.dart';
import 'package:beer_app/widget/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'bloc.dart';

class SpendingPage extends StatefulWidget {
  const SpendingPage({Key? key}) : super(key: key);

  @override
  State<SpendingPage> createState() => _SpendingPageState();
}

class _SpendingPageState extends State<SpendingPage> {
  final SpendingBloc _bloc = SpendingBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc.init();
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text('Расходы', style: BS.bold18.apply(color: BC.brandWhite)),
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
              (state.listSpending?.data?.isNotEmpty ?? false)) {
            final list = state.finances!.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _mainInfo(state, context),
                  const SizedBox(height: 12),
                  const CustomTitleBar(title: 'РАСХОДЫ ЗА МЕСЯЦ', onTap: null),
                  const SizedBox(height: 6),
                  _filters(state),
                  if (list != null &&
                      list.isNotEmpty &&
                      (state.filterListSpending.data?.isEmpty ?? false))
                    for (var i = 0; list.length > i; i++)
                      if (list[i].type == FinanceTypeEnum.SPENDING)
                        CustomActivityItem(
                          item: list[i],
                          canDelete: true,
                          onDelete: () => _bloc.deleteItem(list[i].id),
                          categoryEnum: _bloc.findCategory(
                              list[i], state.listSpending!.data),
                          categoryEnumParser: SpendingCategoryEnumReverse,
                        ),
                  if (state.filterListSpending.data?.isNotEmpty ?? false)
                    for (var i = 0;
                        state.filterListSpending.data!.length > i;
                        i++)
                      if (state.filterListSpending.data![i].type ==
                          FinanceTypeEnum.SPENDING)
                        CustomActivityItem(
                          item: state.filterListSpending.data![i],
                          canDelete: true,
                          onDelete: () => _bloc
                              .deleteItem(state.filterListSpending.data![i].id),
                          categoryEnum: _bloc.findCategory(
                              state.filterListSpending.data![i],
                              state.listSpending!.data),
                          categoryEnumParser: SpendingCategoryEnumReverse,
                        )
                ],
              ),
            );
          } else {
            return const CustomEmptyScreen();
          }
        });
  }

  _mainInfo(ScreenState state, BuildContext context) {
    final allSpending = [
      state.allSpending.products,
      state.allSpending.entertainment,
      state.allSpending.transport,
      state.allSpending.homeproducts,
      state.allSpending.other
    ];
    return Row(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            child: _circularChart(allSpending, context)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; 5 > i; i++)
              _lineInformation(
                  spendingNames[i], allSpending[i], spendingColors[i]),
          ],
        ),
      ],
    );
  }

  Widget _lineInformation(String s, double? allIncome, Color spendingColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: spendingColor,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
          ),
          const SizedBox(width: 4),
          Column(
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
          ),
        ],
      ),
    );
  }

  Widget _circularChart(
    List allSpending,
    BuildContext context,
  ) {
    final data = _bloc.prepareDateForChart(
      allSpending,
    );
    return SfCircularChart(series: <CircularSeries>[
      DoughnutSeries<ChartData, String>(
          dataSource: data,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (ChartData data, _) => data.color,
          // Radius of doughnut
          radius: '100%',
          innerRadius: '60%'),
    ]);
  }

  Widget _filters(ScreenState state) {
    return Row(
      children: [
        Expanded(
            child: Column(
          children: [
            InkWell(
              onTap: () => _bloc.filtering(FiltersEnum.CAT, state),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                    child: Text('По категории',
                        style: BS.reg12.apply(
                            color: state.filter == FiltersEnum.CAT
                                ? BC.brandYellow
                                : BC.brandWhite))),
              ),
            ),
          ],
        )),
        Expanded(
            child: Column(
          children: [
            InkWell(
              onTap: () => _bloc.filtering(FiltersEnum.DATE, state),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                    child: Text('По дате',
                        style: BS.reg12.apply(
                            color: state.filter == FiltersEnum.DATE
                                ? BC.brandYellow
                                : BC.brandWhite))),
              ),
            ),
          ],
        )),
        Expanded(
            child: Column(
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () => _bloc.filtering(FiltersEnum.PRICE, state),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                        child: Text('По сумме',
                            style: BS.reg12.apply(
                                color: state.filter == FiltersEnum.PRICE
                                    ? BC.brandYellow
                                    : BC.brandWhite))),
                  ),
                ),
              ],
            ),
          ],
        )),
      ],
    );
  }
}

enum FiltersEnum { DATE, CAT, PRICE, NONE }
