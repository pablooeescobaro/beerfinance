import 'package:beer_app/data/api/finance.dart';
import 'package:beer_app/data/api/income.dart';
import 'package:beer_app/data/api/saving.dart';
import 'package:beer_app/data/api/spending.dart';
import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/data/dto/income.dart';
import 'package:beer_app/data/dto/saving.dart';
import 'package:beer_app/data/dto/spending.dart';
import 'package:beer_app/screens/home/home_page.dart';
import 'package:beer_app/styles.dart';
import 'package:beer_app/utils/bloc_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final IncomeApi _incomeApi = IncomeApi();
  final SavingApi _savingApi = SavingApi();
  final SpendingApi _spendingApi = SpendingApi();
  final FinanceApi _financeApi = FinanceApi();

  HomeBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    final finances = await _financeApi.getFinances();
    final incomes = await _incomeApi.getIncomes();
    final savings = await _savingApi.getSavings();
    final spending = await _spendingApi.getSpending();
    setState(currentState.copyWith(
        finances: finances,
        incomes: incomes,
        savings: savings,
        spending: spending));
  }

  void changeTypeIncome(String newValue) {
    setState(currentState.copyWith(incomeType: newValue));
  }

  void changeTypeSpending(String newValue) {
    setState(currentState.copyWith(spendingType: newValue));
  }

  Future<void> addIncome(
      BuildContext context, String amount, String name) async {
    final income = IncomeModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      amount: int.parse(amount),
      category: IncomeCategoryEnumMap[currentState.incomeType],
      type: FinanceTypeEnum.INCOME,
      date: DateTime.now().millisecondsSinceEpoch,
    );

    await _incomeApi.saveIncome(income);
    init();
    Navigator.of(context).pop();
  }

  Future<void> addSaving(
      BuildContext context, String amount, String name) async {
    final saving = SavingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      amount: int.parse(amount),
      type: FinanceTypeEnum.SAVING,
      date: DateTime.now().millisecondsSinceEpoch,
    );

    await _savingApi.saveSaving(saving);
    init();
    Navigator.of(context).pop();
  }

  Future<void> addSpending(
      BuildContext context, String amount, String name) async {
    final spending = SpendingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      amount: int.parse(amount),
      date: DateTime.now().millisecondsSinceEpoch,
      category: SpendingCategoryEnumMap[currentState.spendingType],
      type: FinanceTypeEnum.SPENDING,
    );

    await _spendingApi.saveSpending(spending);
    init();
    Navigator.of(context).pop();
  }

  List<ChartData> prepareDateForChart(List<IncomeModel> incomes,
      List<SavingModel> savings, List<SpendingModel> spending) {
    if (incomes.isNotEmpty && savings.isNotEmpty && spending.isNotEmpty) {
      int allIncome = 0;
      int allSpending = 0;
      int allSavings = 0;
      for (var e in incomes) {
        allIncome += e.amount ?? 0;
      }
      for (var e in spending) {
        allSpending += e.amount ?? 0;
      }
      for (var e in savings) {
        allSavings += e.amount ?? 0;
      }
      return <ChartData>[
        ChartData('Доход', allIncome.toDouble(), BC.brandWhite),
        ChartData('Траты', (allSpending + allSavings).toDouble(), BC.brandYellow)
      ];
    } else {
      return <ChartData>[
        ChartData('Доход', 0, BC.brandWhite),
        ChartData('Траты', 0, BC.brandWhite)
      ];
    }
  }

  String parsePercent(List<ChartData> data) {
    final percent = ((data[1].y / data[0].y ) * 100).toStringAsPrecision(3);
    return percent.toString() + '%';
  }
}

class ScreenState {
  final IncomeModel? incomeModel;
  final ListFinance? finances;
  final String? incomeType;
  final String? spendingType;
  final ListIncome? incomes;
  final ListSaving? savings;
  final ListSpending? spending;

  ScreenState({
    this.incomeModel,
    this.incomeType,
    this.spendingType,
    this.finances,
    this.incomes,
    this.savings,
    this.spending,
  });

  ScreenState copyWith({
    IncomeModel? incomeModel,
    String? incomeType,
    String? spendingType,
    ListFinance? finances,
    ListIncome? incomes,
    ListSaving? savings,
    ListSpending? spending,
  }) {
    return ScreenState(
      incomeModel: incomeModel ?? this.incomeModel,
      incomeType: incomeType ?? this.incomeType,
      spendingType: spendingType ?? this.spendingType,
      finances: finances ?? this.finances,
      incomes: incomes ?? this.incomes,
      savings: savings ?? this.savings,
      spending: spending ?? this.spending,
    );
  }
}
