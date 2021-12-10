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
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final IncomeApi _incomeApi = IncomeApi();
  final SavingApi _savingApi = SavingApi();
  final SpendingApi _spendingApi = SpendingApi();
  final FinanceApi _financeApi = FinanceApi();

  HomeBloc() {
    setState(ScreenState(incomeType: 'Основной доход', spendingType: 'Другое'));
  }

  Future<void> init() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final finances = await _financeApi.getFinances();
    final incomes = await _incomeApi.getIncomes();
    final savings = await _savingApi.getSavings();
    final spending = await _spendingApi.getSpending();
    final financeModel = AllFinanceModel();

    if (incomes.data != null) {
      for (var e in incomes.data ?? []) {
        financeModel.allIncome += e.amount ?? 0;
      }
    } else {
      financeModel.allIncome = 0;
    }

    if (spending.data != null) {
      for (var e in spending.data ?? []) {
        financeModel.allSpending += e.amount ?? 0;
      }
    } else {
      financeModel.allSpending = 0;
    }

    if (savings.data != null) {
      for (var e in savings.data ?? []) {
        financeModel.allSavings += e.amount ?? 0;
      }
    } else {
      financeModel.allSavings = 0;
    }

    if (finances.data != null && (finances.data?.isNotEmpty ?? false)) {
      finances.data!.sort((a, b) => (a.date ?? 0) > (b.date ?? 0) ? -1 : 1);
    }
    if (incomes.data != null && (incomes.data?.isNotEmpty ?? false)) {
      incomes.data!.sort((a, b) => (a.date ?? 0) > (b.date ?? 0) ? -1 : 1);
    }
    if (savings.data != null && (savings.data?.isNotEmpty ?? false)) {
      savings.data!.sort((a, b) => (a.date ?? 0) > (b.date ?? 0) ? -1 : 1);
    }
    if (spending.data != null && (spending.data?.isNotEmpty ?? false)) {
      spending.data!.sort((a, b) => (a.date ?? 0) > (b.date ?? 0) ? -1 : 1);
    }

    String? limit = _prefs.getString('limit');
    if (limit == null) {
      await _prefs.setString('limit', '2000');
      limit = _prefs.getString('limit');
    }

    setState(currentState.copyWith(
      finances: finances,
      incomes: incomes,
      savings: savings,
      spending: spending,
      allFinance: financeModel,
      hasAmount: true,
      hasName: true,
      limit: double.parse(limit ?? '0'),
    ));
  }

  void changeTypeIncome(String newValue) {
    setState(currentState.copyWith(incomeType: newValue));
  }

  void changeTypeSpending(String newValue) {
    setState(currentState.copyWith(spendingType: newValue));
  }

  Future<void> addIncome(
      BuildContext context, String amount, String name) async {
    if (amount != '' && name != '') {
      final income = IncomeModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        amount: double.parse(amount.replaceAll(',', '.')),
        category: IncomeCategoryEnumMap[currentState.incomeType],
        type: FinanceTypeEnum.INCOME,
        date: DateTime.now().millisecondsSinceEpoch,
      );

      await _incomeApi.saveIncome(income);
      init();
      Navigator.of(context).pop();
    } else {
      setState(currentState.copyWith(hasName: false, hasAmount: false));
    }
  }

  Future<void> addSaving(
      BuildContext context, String amount, String name) async {
    if (amount != '' && name != '') {
      final saving = SavingModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        amount: double.parse(amount),
        type: FinanceTypeEnum.SAVING,
        date: DateTime.now().millisecondsSinceEpoch,
      );

      await _savingApi.saveSaving(saving);
      init();
      Navigator.of(context).pop();
    } else {
      setState(currentState.copyWith(hasName: false, hasAmount: false));
    }
  }

  Future<void> addSpending(
      BuildContext context, String amount, String name) async {
    if (amount != '' && name != '') {
      final spending = SpendingModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        amount: double.parse(amount),
        date: DateTime.now().millisecondsSinceEpoch,
        category: SpendingCategoryEnumMap[currentState.spendingType],
        type: FinanceTypeEnum.SPENDING,
      );

      if (currentState.limit <
          ((currentState.allFinance?.allSpending ?? 0)) +
              double.parse(amount)) {
        sendActionError();
      } else {
        await _spendingApi.saveSpending(spending);
      }
      init();
      Navigator.of(context).pop();
    } else {
      setState(currentState.copyWith(hasName: false, hasAmount: false));
    }
  }

  List<ChartData> prepareDateForChart(AllFinanceModel allFinance) {
    if (allFinance.allIncome == 0 &&
        allFinance.allSpending == 0 &&
        allFinance.allSavings == 0) {
      return <ChartData>[
        ChartData('Доход', 100, BC.brandWhite),
        ChartData('Траты', 0, BC.brandYellow)
      ];
    } else if ((allFinance.allSpending + allFinance.allSavings) /
            allFinance.allIncome >
        1) {
      return <ChartData>[
        ChartData('Доход', 0, BC.brandWhite),
        ChartData('Траты', 100, BC.brandYellow)
      ];
    } else {
      return <ChartData>[
        ChartData('Доход', allFinance.allIncome, BC.brandWhite),
        ChartData('Траты', (allFinance.allSpending) + (allFinance.allSavings),
            BC.brandYellow)
      ];
    }
  }

  String parsePercent(List<ChartData> data) {
    String percent = '';
    if ((data[1].y / data[0].y) < 1) {
      percent = ((data[1].y / data[0].y) * 100).toStringAsPrecision(3);
    } else {
      percent = '100.00';
    }
    return percent.toString() + '%';
  }

  Future<void> setLimit(
      String text, double allSpending, BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (text == '' || (double.parse(text) < allSpending)) {
      setState(currentState.copyWith(errLimit: true));
    } else {
      await _prefs.setString('limit', text);
      final newLimit = _prefs.getString('limit');
      setState(currentState.copyWith(
          errLimit: false, limit: double.parse(newLimit ?? '$allSpending')));
      init();
      Navigator.of(context).pop();
    }
  }

  void deleteLimitErr() {
    setState(currentState.copyWith(errLimit: false));
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
  final AllFinanceModel? allFinance;
  final bool hasName;
  final bool hasAmount;
  final bool errLimit;
  final double limit;

  ScreenState(
      {this.incomeModel,
      this.incomeType,
      this.spendingType,
      this.finances,
      this.incomes,
      this.savings,
      this.spending,
      this.allFinance,
      this.hasName = true,
      this.hasAmount = true,
      this.errLimit = false,
      this.limit = 0});

  ScreenState copyWith({
    IncomeModel? incomeModel,
    String? incomeType,
    String? spendingType,
    ListFinance? finances,
    ListIncome? incomes,
    ListSaving? savings,
    ListSpending? spending,
    AllFinanceModel? allFinance,
    bool? hasName,
    bool? hasAmount,
    bool? errLimit,
    double? limit,
  }) {
    return ScreenState(
      incomeModel: incomeModel ?? this.incomeModel,
      incomeType: incomeType ?? this.incomeType,
      spendingType: spendingType ?? this.spendingType,
      finances: finances ?? this.finances,
      incomes: incomes ?? this.incomes,
      savings: savings ?? this.savings,
      spending: spending ?? this.spending,
      allFinance: allFinance ?? this.allFinance,
      hasName: hasName ?? this.hasName,
      hasAmount: hasAmount ?? this.hasAmount,
      errLimit: errLimit ?? this.errLimit,
      limit: limit ?? this.limit,
    );
  }
}
