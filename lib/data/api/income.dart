import 'dart:convert';

import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/data/dto/income.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeApi {
  Future<void> saveIncome(income) async {
    final prefs = await SharedPreferences.getInstance();

    final result = await prefs.setString(income.id ?? '', jsonEncode(income));
    final list = prefs.getString('incomes');
    if (list != null) {
      final listIncome = ListIncome.fromJson(jsonDecode(list));
      listIncome.data!.add(income);
      final result = await prefs.setString('incomes', jsonEncode(listIncome));
    } else {
      final result = await prefs.setString(
          'incomes', jsonEncode(ListIncome(data: [income])));
    }
  }

  Future<IncomeModel> getIncome(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString(id);

    return IncomeModel.fromJson(jsonDecode(result ?? ''));
  }

  Future<ListIncome> getIncomes() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('incomes');

    if(result != null){
      return ListIncome.fromJson(jsonDecode(result));
    } else {
      return ListIncome();
    }
  }

  Future<List<FinanceModel>> getFinanceList() async {
    final prefs = await SharedPreferences.getInstance();
    final result =
        ListIncome.fromJson(jsonDecode(prefs.getString('incomes') ?? '')).data;

    final List<FinanceModel> finances = [];
    if (result != null) {
      for (var i = 0; result.length > i; i++) {
        final e = result[i];
        finances.add(FinanceModel(
            id: e.id,
            date: e.date,
            amount: e.amount,
            type: e.type,
            name: e.name));
      }
      return finances;
    } else {
      return <FinanceModel>[];
    }
  }
}
