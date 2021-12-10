import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/screens/home/home_main_activity.dart';
import 'package:beer_app/screens/home/home_main_information.dart';
import 'package:beer_app/styles.dart';
import 'package:beer_app/widget/action_handler.dart';
import 'package:beer_app/widget/bottom_sheet_border.dart';
import 'package:beer_app/widget/button.dart';
import 'package:beer_app/widget/dropdown_button.dart';
import 'package:beer_app/widget/page_error_handler.dart';
import 'package:beer_app/widget/progress_indicator.dart';
import 'package:beer_app/widget/text_field.dart';
import 'package:beer_app/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
  final FocusNode _focusName = FocusNode();
  final FocusNode _focusPrice = FocusNode();

  @override
  void initState() {
    _bloc.init();
    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerPrice.dispose();
    _focusPrice.dispose();
    _focusName.dispose();
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
    return ActionHandler(
      stream: _bloc.actions,
      handler: _handleAction,
      child: StreamBuilder<ScreenState>(
          stream: _bloc.state,
          initialData: _bloc.currentState,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state != null &&
                state.finances != null &&
                state.incomes != null &&
                state.savings != null &&
                state.spending != null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: [
                          HomeMainInformation(
                              allFinance: state.allFinance ??
                                  AllFinanceModel(
                                    allSavings: 0,
                                    allSpending: 0,
                                    allIncome: 0,
                                  ),
                              bloc: _bloc),
                          HomeMainActivity(state: state, bloc: _bloc),
                        ],
                      ),
                    ),
                  ),
                  _mainButton(context),
                ],
              );
            } else {
              return Center(
                child: CustomProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget _mainButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: BC.brandBlack,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          )),
      padding: EdgeInsets.only(bottom: 4, top: 4),
      height: 58,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            text: 'ВНЕСТИ ДОХОД',
            width: MediaQuery.of(context).size.width / 3 - 8,
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
            width: MediaQuery.of(context).size.width / 3 - 8,
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
                            errText: state.hasName ? null : 'Введите описание',
                            controller: _controllerPrice,
                            textInputAction: TextInputAction.next,
                            focus: _focusName,
                            onFieldSubmitted: () => {
                              _focusName.unfocus(),
                              FocusScope.of(context).requestFocus(_focusPrice),
                            },
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: 'Сумма',
                            errText: state.hasName ? null : 'Введите сумму',
                            controller: _controllerName,
                            type: TextInputType.number,
                            focus: _focusPrice,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+(\.|\,)?(\d{1,2}|\d{3})?'))
                            ],
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
                            errText: state.hasName ? null : 'Введите описание',
                            controller: _controllerPrice,
                            textInputAction: TextInputAction.next,
                            focus: _focusName,
                            onFieldSubmitted: () => {
                              _focusName.unfocus(),
                              FocusScope.of(context).requestFocus(_focusPrice),
                            },
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: 'Сумма',
                            errText: state.hasName ? null : 'Введите сумму',
                            controller: _controllerName,
                            type: TextInputType.number,
                            focus: _focusPrice,
                            onFieldSubmitted: () => {
                              _bloc.addSaving(context, _controllerName.text,
                                  _controllerPrice.text),
                            },
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+(\.|\,)?(\d{1,2}|\d{3})?')),
                            ],
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
                            errText: state.hasName ? null : 'Введите описание',
                            controller: _controllerPrice,
                            textInputAction: TextInputAction.next,
                            focus: _focusName,
                            onFieldSubmitted: () => {
                              _focusName.unfocus(),
                              FocusScope.of(context).requestFocus(_focusPrice),
                            },
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: 'Сумма',
                            errText: state.hasName ? null : 'Введите сумму',
                            controller: _controllerName,
                            type: TextInputType.number,
                            focus: _focusPrice,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+(\.|\,)?(\d{1,2}|\d{3})?')),
                            ],
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

  void _handleAction(ActionEvent event, BuildContext context) {
    if (event.isShowErrorAction) {
      PageErrorHandler.showGenericError(context,
          errorMessage: 'Невозожно внести расход, измините лимит.');
    }
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
