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

    if (result != null) {
      return ListSaving.fromJson(jsonDecode(result));
    } else {
      return ListSaving();
    }
  }

  Future<void> deleteSaving(String id) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(id);
    final list = prefs.getString('savings');
    final listSaving = ListSaving.fromJson(jsonDecode(list!));
    listSaving.data!.removeWhere((element) => element.id == id);
    await prefs.setString('savings', jsonEncode(listSaving));
  }

  Future<List<FinanceModel>> getFinanceList() async {
    final prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('savings') ?? '';

    final List<FinanceModel> finances = [];
    if (response != '') {
      final result = ListSaving.fromJson(jsonDecode(response)).data;
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
    } else {
      return <FinanceModel>[];
    }
  }
}
