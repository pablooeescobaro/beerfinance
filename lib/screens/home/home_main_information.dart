import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/generated/assets.gen.dart';
import 'package:beer_app/screens/home/home_bloc.dart';
import 'package:beer_app/screens/home/home_page.dart';
import 'package:beer_app/styles.dart';
import 'package:beer_app/utils/custom_function.dart';
import 'package:beer_app/widget/bottom_sheet_border.dart';
import 'package:beer_app/widget/button.dart';
import 'package:beer_app/widget/text_field.dart';
import 'package:beer_app/widget/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'home_bloc.dart';

class HomeMainInformation extends StatefulWidget {
  const HomeMainInformation(
      {Key? key, required this.allFinance, required this.bloc})
      : super(key: key);
  final AllFinanceModel allFinance;
  final HomeBloc bloc;

  @override
  State<HomeMainInformation> createState() => _HomeMainInformationState();
}

class _HomeMainInformationState extends State<HomeMainInformation> {
  final TextEditingController _controllerLimit = TextEditingController();
  final FocusNode _focusLimit = FocusNode();

  @override
  void dispose() {
    _controllerLimit.dispose();
    _focusLimit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ScreenState>(
        stream: widget.bloc.state,
        initialData: widget.bloc.currentState,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state != null) {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                        child: _circularChart(
                          state,
                          context,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _lineInformation(
                              'Общие доходы:', widget.allFinance.allIncome),
                          const SizedBox(
                            height: 8,
                          ),
                          _lineInformation(
                              'Общие расходы:', widget.allFinance.allSpending),
                          const SizedBox(
                            height: 8,
                          ),
                          _lineInformation('Общие сбережения:',
                              widget.allFinance.allSavings),
                          const SizedBox(
                            height: 8,
                          ),
                          _lineInformation(
                              'Остататок средств:',
                              widget.allFinance.allIncome -
                                  (widget.allFinance.allSpending +
                                      widget.allFinance.allSavings)),
                        ],
                      )
                    ],
                  ),
                ),
                _linearPercentIndicator(
                    state.limit, context, state.allFinance?.allSpending ?? 0),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  _circularChart(
    ScreenState state,
    BuildContext context,
  ) {
    final data = widget.bloc.prepareDateForChart(state.allFinance ??
        AllFinanceModel(
          allSavings: 0,
          allSpending: 0,
          allIncome: 0,
        ));
    return Stack(
      alignment: Alignment.center,
      children: [
        SfCircularChart(series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              pointColorMapper: (ChartData data, _) => data.color,
              // Radius of doughnut
              radius: '100%',
              innerRadius: '60%'),
        ]),
        Text(
          widget.bloc.parsePercent(data),
          style: BS.reg18.apply(color: BC.brandYellow),
        ),
      ],
    );
  }

  Widget _lineInformation(String s, double allIncome) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s,
          style: BS.reg12.apply(color: BC.brandWhite),
        ),
        Text(
          parseBigAmount((allIncome)) + '₴',
          style: BS.reg12.apply(color: BC.brandYellow),
        ),
      ],
    );
  }

  _linearPercentIndicator(double limit, BuildContext context, double spending) {
    final limitString = limit.toStringAsFixed(0);
    return InkWell(
      onTap: () => {
        _showChangeLimit(context),
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Лимит на расходы равен: $limitString₴',
                      style: BS.reg12.apply(color: BC.brandWhite),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Assets.icons.iPen
                          .svg(width: 16, height: 16, color: BC.brandWhite),
                    )
                  ],
                ),
              ),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 32,
                lineHeight: 8.0,
                percent: spending / limit,
                progressColor: BC.brandYellow,
                backgroundColor: BC.brandWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showChangeLimit(BuildContext context) {
    showMaterialModalBottomSheet(
        shape: const BottomSheetBorder(),
        context: context,
        builder: (context) {
          return StreamBuilder<ScreenState>(
              stream: widget.bloc.state,
              initialData: widget.bloc.currentState,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state != null) {
                  final allSpendingForErr =
                      (state.allFinance?.allSpending ?? 0).toStringAsFixed(0);
                  _controllerLimit.text = state.limit.toStringAsFixed(0);
                  return Container(
                    margin: const EdgeInsets.fromLTRB(16, 30, 16, 16),
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).size.height / 10,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      CustomTitle(
                        text: 'ИЗМЕНИТЬ ЛИМИТ',
                        color: BC.brandBlack,
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: 'Сумма',
                        errText: state.errLimit
                            ? 'Введите лимит больше $allSpendingForErr'
                            : null,
                        controller: _controllerLimit,
                        type: TextInputType.number,
                        focus: _focusLimit,
                        onFieldSubmitted: () => {
                          _focusLimit.unfocus(),
                          widget.bloc.setLimit(_controllerLimit.text,
                              widget.allFinance.allSpending, context),
                        },
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomButton(
                        color: BC.brandBlack,
                        bGColor: BC.brandBlack,
                        height: 40,
                        text: 'ИЗМЕНИТЬ',
                        onTap: () {
                          widget.bloc.setLimit(_controllerLimit.text,
                              widget.allFinance.allSpending, context);
                        },
                      )
                    ]),
                  );
                } else {
                  return SizedBox.shrink();
                }
              });
        }).whenComplete(() => widget.bloc.deleteLimitErr());
  }
}
