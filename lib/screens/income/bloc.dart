import 'package:beer_app/data/api/finance.dart';
import 'package:beer_app/data/api/income.dart';
import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/data/dto/income.dart';
import 'package:beer_app/utils/bloc_base.dart';

class IncomeBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final IncomeApi _incomeApi = IncomeApi();
  final FinanceApi _financeApi = FinanceApi();

  IncomeBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    final incomes = await _incomeApi.getIncomes();
    final finances = await _financeApi.getFinances();
    prepareDate(incomes.data);
    setState(currentState.copyWith(listIncome: incomes, finances: finances));
  }

  deleteItem(String? id) async {
    await _incomeApi.deleteIncome(id ?? '');
    init();
  }

  prepareDate(List<IncomeModel>? list) {
    if (list != null && list.isNotEmpty) {
      double mainIncome = 0;
      double sideIncome = 0;
      for (var e in list) {
        e.category == IncomeCategoryEnum.MAININCOME
            ? mainIncome += (e.amount ?? 0)
            : sideIncome += (e.amount ?? 0);
      }
      setState(currentState.copyWith(
          mainIncome: mainIncome, sideIncome: sideIncome));
    } else {
      setState(currentState.copyWith(mainIncome: 0, sideIncome: 0));
    }
  }

  String parsePercent(data) {
    return '';
  }

  findCategory(FinanceModel listItem, data) {
    for (var item in data ?? []) {
      if (listItem.id == item.id) {
        return item.category;
      }
    }
  }
}

class ScreenState {
  final ListIncome? listIncome;
  final ListFinance? finances;
  final double? mainIncome;
  final double? sideIncome;

  ScreenState({
    this.listIncome,
    this.finances,
    this.mainIncome,
    this.sideIncome,
  });

  ScreenState copyWith({
    ListIncome? listIncome,
    ListFinance? finances,
    double? mainIncome,
    double? sideIncome,
  }) {
    return ScreenState(
      listIncome: listIncome ?? this.listIncome,
      finances: finances ?? this.finances,
      mainIncome: mainIncome ?? this.mainIncome,
      sideIncome: sideIncome ?? this.sideIncome,
    );
  }
}
