import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/data/dto/income.dart';
import 'package:beer_app/data/dto/saving.dart';
import 'package:beer_app/data/dto/spending.dart';
import 'package:beer_app/styles.dart';
import 'package:beer_app/widget/bottom_sheet_border.dart';
import 'package:beer_app/widget/buttom.dart';
import 'package:beer_app/widget/dropdown_button.dart';
import 'package:beer_app/widget/progress_indicator.dart';
import 'package:beer_app/widget/text_field.dart';
import 'package:beer_app/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

HomeBloc _bloc = HomeBloc();

class _HomePageState extends State<HomePage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerPrice.dispose();
    super.dispose();
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
      title: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: 'Beer',
          style: BS.bold18.apply(color: BC.brandWhite),
        ),
        TextSpan(
          text: 'Finance',
          style: BS.bold18.apply(color: BC.brandYellow),
        ),
      ])),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _mainInformation(context),
        _mainActivity(context),
        _mainButton(context),
      ],
    );
  }

  Widget _mainInformation(BuildContext context) {
    return Container();
  }

  Widget _mainActivity(BuildContext context) {
    return StreamBuilder<ScreenState>(
        stream: _bloc.state,
        initialData: _bloc.currentState,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state != null &&
              state.finances != null &&
              state.incomes != null &&
              state.savings != null &&
              state.spending != null) {
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _circularChart(
                      context,
                      state.incomes?.data ?? <IncomeModel>[],
                      state.savings?.data ?? <SavingModel>[],
                      state.spending?.data ?? <SpendingModel>[],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CustomProgressIndicator(),
            );
          }
        });
  }

  Widget _mainButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            text: 'ВНЕСТИ ДОХОД',
            width: MediaQuery.of(context).size.width / 3 - 2,
            onTap: () => _showAddIncome(context),
            margin: 1,
          ),
          CustomButton(
            text: 'ВНЕСТИ СБЕРЕЖЕНИЕ',
            width: MediaQuery.of(context).size.width / 3 - 2,
            onTap: () => _showAddSaving(context),
            margin: 1,
          ),
          CustomButton(
            text: 'ВНЕСТИ ТРАТУ',
            width: MediaQuery.of(context).size.width / 3 - 2,
            onTap: () => _showAddSpending(context),
            margin: 1,
          ),
        ],
      ),
    );
  }

  _showAddIncome(BuildContext context) {
    showMaterialModalBottomSheet(
        shape: const BottomSheetBorder(),
        context: context,
        builder: (context) {
          return StreamBuilder<ScreenState>(
              stream: _bloc.state,
              initialData: _bloc.currentState,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state != null) {
                  return Container(
                      margin: const EdgeInsets.fromLTRB(16, 30, 16, 16),
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height / 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTitle(
                            text: 'ВНЕСТИ ДОХОД',
                            color: BC.brandBlack,
                          ),
                          const SizedBox(height: 34),
                          CustomTextField(
                            hintText: 'Описание',
                            controller: _controllerPrice,
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: 'Сумма',
                            controller: _controllerName,
                            type: TextInputType.number,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropdownButton(
                                  values: const [
                                    'Основной доход',
                                    'Подработка'
                                  ],
                                  actualValue: state.incomeType,
                                  onChanged: (String? newValue) {
                                    _bloc.changeTypeIncome(newValue ?? '');
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              CustomButton(
                                color: BC.brandBlack,
                                bGColor: BC.brandBlack,
                                width: 100,
                                height: 40,
                                text: 'ВНЕСТИ',
                                onTap: () {
                                  _bloc.addIncome(context, _controllerName.text,
                                      _controllerPrice.text);
                                  _clearInputs();
                                },
                              ),
                            ],
                          )
                        ],
                      ));
                } else {
                  return SizedBox.shrink();
                }
              });
        }).whenComplete(() => _clearInputs());
  }

  _showAddSaving(BuildContext context) {
    showMaterialModalBottomSheet(
        shape: const BottomSheetBorder(),
        context: context,
        builder: (context) {
          return StreamBuilder<ScreenState>(
              stream: _bloc.state,
              initialData: _bloc.currentState,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state != null) {
                  return Container(
                      margin: const EdgeInsets.fromLTRB(16, 30, 16, 16),
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height / 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTitle(
                            text: 'ВНЕСТИ СБЕРЕЖЕНИЕ',
                            color: BC.brandBlack,
                          ),
                          const SizedBox(height: 34),
                          CustomTextField(
                            hintText: 'Описание',
                            controller: _controllerPrice,
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: 'Сумма',
                            controller: _controllerName,
                            type: TextInputType.number,
                          ),
                          const SizedBox(height: 8),
                          CustomButton(
                            color: BC.brandBlack,
                            bGColor: BC.brandBlack,
                            height: 40,
                            text: 'ВНЕСТИ',
                            onTap: () {
                              _bloc.addSaving(context, _controllerName.text,
                                  _controllerPrice.text);
                              _clearInputs();
                            },
                          )
                        ],
                      ));
                } else {
                  return SizedBox.shrink();
                }
              });
        }).whenComplete(() => _clearInputs());
  }

  _showAddSpending(BuildContext context) {
    showMaterialModalBottomSheet(
        shape: const BottomSheetBorder(),
        context: context,
        builder: (context) {
          return StreamBuilder<ScreenState>(
              stream: _bloc.state,
              initialData: _bloc.currentState,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state != null) {
                  return Container(
                      margin: const EdgeInsets.fromLTRB(16, 30, 16, 16),
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height / 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTitle(
                            text: 'ВНЕСТИ ТРАТУ',
                            color: BC.brandBlack,
                          ),
                          const SizedBox(height: 34),
                          CustomTextField(
                            hintText: 'Описание',
                            controller: _controllerPrice,
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: 'Сумма',
                            controller: _controllerName,
                            type: TextInputType.number,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropdownButton(
                                  values: const [
                                    'Продукты',
                                    'Развлечения',
                                    'Транспорт',
                                    'Товары для дома',
                                    'Другое',
                                  ],
                                  actualValue: state.spendingType,
                                  onChanged: (String? newValue) {
                                    _bloc.changeTypeSpending(newValue ?? '');
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              CustomButton(
                                color: BC.brandBlack,
                                bGColor: BC.brandBlack,
                                width: 100,
                                height: 40,
                                text: 'ВНЕСТИ',
                                onTap: () {
                                  _bloc.addSpending(
                                      context,
                                      _controllerName.text,
                                      _controllerPrice.text);
                                  _clearInputs();
                                },
                              ),
                            ],
                          )
                        ],
                      ));
                } else {
                  return SizedBox.shrink();
                }
              });
        }).whenComplete(() => _clearInputs());
  }

  void _clearInputs() {
    _controllerName.text = '';
    _controllerPrice.text = '';
  }

  _circularChart(
    BuildContext context,
    List<IncomeModel> incomes,
    List<SavingModel> savings,
    List<SpendingModel> spending,
  ) {
    final data = _bloc.prepareDateForChart(incomes, savings, spending);
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
              radius: '100%')
        ]),
        Text(
          _bloc.parsePercent(data),
          style: BS.reg18.apply(color: BC.brandYellow),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
