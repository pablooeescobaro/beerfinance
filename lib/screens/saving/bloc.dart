import 'package:beer_app/data/api/finance.dart';
import 'package:beer_app/data/api/saving.dart';
import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/data/dto/saving.dart';
import 'package:beer_app/utils/bloc_base.dart';

class SavingBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final SavingApi _savingApi = SavingApi();
  final FinanceApi _financeApi = FinanceApi();

  SavingBloc() {
    setState(ScreenState());
  }

  Future<void> init() async {
    final savings = await _savingApi.getSavings();
    final finances = await _financeApi.getFinances();
    setState(currentState.copyWith(savings: savings, finances: finances));
  }

  deleteItem(String? id) async {
    await _savingApi.deleteSaving(id ?? '');
    init();
  }
}

class ScreenState {
  final ListFinance? finances;
  final ListSaving? savings;

  ScreenState({
    this.finances,
    this.savings,
  });

  ScreenState copyWith({
    ListFinance? finances,
    ListSaving? savings,
  }) {
    return ScreenState(
      finances: finances ?? this.finances,
      savings: savings ?? this.savings,
    );
  }
}
