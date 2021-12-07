import 'dart:convert';

import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/data/dto/saving.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavingApi {
  Future<void> saveSaving(saving) async {
    final prefs = await SharedPreferences.getInstance();

    final result = await prefs.setString(saving.id ?? '', jsonEncode(saving));
    final list = prefs.getString('savings');
    if (list != null) {
      final listSaving = ListSaving.fromJson(jsonDecode(list));
      listSaving.data!.add(saving);
      final result = await prefs.setString('savings', jsonEncode(listSaving));
    } else {
      final result = await prefs.setString(
          'savings', jsonEncode(ListSaving(data: [saving])));
    }
  }

  Future<SavingModel> getSaving(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString(id);

    return SavingModel.fromJson(jsonDecode(result ?? ''));
  }

  Future<ListSaving> getSavings() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('savings');

    return ListSaving.fromJson(jsonDecode(result ?? ''));
  }

  Future<List<FinanceModel>> getFinanceList() async {
    final prefs = await SharedPreferences.getInstance();
    final result =
        ListSaving.fromJson(jsonDecode(prefs.getString('savings') ?? '')).data;

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
