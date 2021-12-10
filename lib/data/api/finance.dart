import 'package:beer_app/data/api/income.dart';
import 'package:beer_app/data/api/saving.dart';
import 'package:beer_app/data/api/spending.dart';
import 'package:beer_app/data/dto/finance.dart';

class FinanceApi {
  Future<ListFinance> getFinances() async {
    final IncomeApi _incomeApi = IncomeApi();
    final SavingApi _savingApi = SavingApi();
    final SpendingApi _spendingApi = SpendingApi();

    final finances = <FinanceModel>[];
    final incomes = await _incomeApi.getFinanceList();
    final saving = await _savingApi.getFinanceList();
    final spending = await _spendingApi.getFinanceList();

    finances.addAll(incomes);
    finances.addAll(saving);
    finances.addAll(spending);

    finances.sort((a, b) => (a.date ?? 0) < (b.date ?? 0) ? 1 : -1);

    return ListFinance(data: finances);
  }
}
