import 'package:beer_app/data/api/finance.dart';
import 'package:beer_app/data/api/income.dart';
import 'package:beer_app/data/api/saving.dart';
import 'package:beer_app/data/api/spending.dart';
import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/utils/bloc_base.dart';

class ActivityBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final FinanceApi _financeApi = FinanceApi();
  final IncomeApi _incomeApi = IncomeApi();
  final SavingApi _savingApi = SavingApi();
  final SpendingApi _spendingApi = SpendingApi();

  ActivityBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    final finances = await _financeApi.getFinances();
    setState(currentState.copyWith(finances: finances));
  }

  deleteItem(FinanceTypeEnum? type, String? id) async {
    switch (type) {
      case FinanceTypeEnum.INCOME:
        await _incomeApi.deleteIncome(id ?? '');
        init();
        break;
      case FinanceTypeEnum.SPENDING:
        await _spendingApi.deleteSpending(id ?? '');
        init();
        break;
      case FinanceTypeEnum.SAVING:
        await _savingApi.deleteSaving(id ?? '');
        init();
        break;
      default:
    }
  }
}

class ScreenState {
  final ListFinance? finances;

  ScreenState({
    this.finances,
  });

  ScreenState copyWith({
    ListFinance? finances,
  }) {
    return ScreenState(
      finances: finances ?? this.finances,
    );
  }
}
